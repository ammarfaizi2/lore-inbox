Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTGBTRC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 15:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264447AbTGBTRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 15:17:02 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264434AbTGBTQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 15:16:58 -0400
Date: Wed, 2 Jul 2003 12:31:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@digeo.com>
cc: Andries.Brouwer@cwi.nl, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cryptoloop
In-Reply-To: <20030702122012.0c5ad0a6.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0307021230460.1645-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Jul 2003, Andrew Morton wrote:
> 
> Well please don't let me stand in the way of #3.  But we shouldn't lose
> sight of the need to fix up these shortcomings.  pagecache&BIO use
> pageframes and crypto uses pageframes.  Connecting them together via
> virtual addresses is daft.

I do agree. Might as well fix that, if patch#3 is working in that area 
anyway.

		Linus

