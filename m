Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbTCGHv1>; Fri, 7 Mar 2003 02:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbTCGHv1>; Fri, 7 Mar 2003 02:51:27 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:53116 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S261413AbTCGHv0>; Fri, 7 Mar 2003 02:51:26 -0500
Date: Fri, 7 Mar 2003 08:52:42 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <aia21@cantab.net>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <32995.4.64.238.61.1047023411.squirrel@www.osdl.org>
Message-ID: <Pine.LNX.4.30.0303070845130.32-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Randy.Dunlap wrote:

> I tried to decode the disassembly, got lots of it done,
> but I bogged down on something that may be outside of the
> NTFS realm.  I have ALL kernel hacking options enabled
> (=y), and it's a bit hairy (for me) to decode all of the
> extra/added code, and this may be where the oops is
> happening.  Dunno really, just wanted to warn you.

This was one of the issues I suspected (lots of hacking option) and
asked for .config also. Your __ntfs_init_inode was *huge* and the oops
Code didn't resembled to any of written in __ntfs_init_inode ...
unless you have some hardware issue (bit flips, memory/CPU, etc). When
I have time I'll also take a closer look. I don't exclude some
alignment issues either ...

	Szaka

