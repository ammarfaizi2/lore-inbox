Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTJIOov (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 10:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTJIOov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 10:44:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:29365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262056AbTJIOou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 10:44:50 -0400
Date: Thu, 9 Oct 2003 07:44:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <bos@serpentine.com>
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
In-Reply-To: <20031009104218.GA1935@averell>
Message-ID: <Pine.LNX.4.44.0310090743210.1694-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is too ugly for words.

Just make mlockall() ignore any mappings that are not readable.

		Linus

