Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUBREs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUBREs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:48:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:32685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263625AbUBREsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:48:53 -0500
Date: Tue, 17 Feb 2004 20:48:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver 
In-Reply-To: <7789.1077077976@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.58.0402172047550.2686@home.osdl.org>
References: <7789.1077077976@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Keith Owens wrote:
> 
> There is no scope for a compiler to reorder the members or the bit
> fields of a structure.

The actual bit ordering is implementation-defined, though, so in effect 
the bitfield setup _does_ depend on the compiler and architecture details.

		Linus
