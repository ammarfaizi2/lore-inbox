Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266675AbUBQVzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266654AbUBQVx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:53:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:64482 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266651AbUBQVtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:49:06 -0500
Date: Tue, 17 Feb 2004 13:48:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Alex Belits <abelits@phobos.illtel.denver.co.us>,
       Marc Lehmann <pcg@schmorp.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040217210919.GG24311@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402171347420.2154@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de>
 <Pine.LNX.4.58.0402161603420.10177@sm1420.belits.com>
 <20040217210919.GG24311@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Jamie Lokier wrote:
> 
> >   I can point at the example of this "solution" that happened years ago
> > when UCS-2 was all the rage, and it got hardcoded and enforced by NTFS
> > and everything that handles it. Who is laughing about that decision now?
> 
> We are all laughing ;)

Crying. Sadly, when MS makes a whopper of a mistake (and they do it all 
too often), we're left having to work with the resulting breakage.

I suspect most samba developers are already technically insane (*).

		Linus

(*) Of course, since many of them are Australians, you can't tell.
