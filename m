Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRLHSyu>; Sat, 8 Dec 2001 13:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284015AbRLHSyk>; Sat, 8 Dec 2001 13:54:40 -0500
Received: from nc-ashvl-66-169-84-151.charternc.net ([66.169.84.151]:3712 "EHLO
	orp.orf.cx") by vger.kernel.org with ESMTP id <S283995AbRLHSyX>;
	Sat, 8 Dec 2001 13:54:23 -0500
Message-Id: <200112081854.fB8IsIr01485@orp.orf.cx>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
From: Leigh Orf <orf@mailbag.com>
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcDb+Y'p'sCMJ
Subject: Re: 2.4.16 memory badness (reproducible) 
In-Reply-To: Your message of "Sat, 08 Dec 2001 09:56:20 CST."
             <20011208095620.C1179@asooo.flowerfire.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 13:54:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ken Brownfield wrote:

|   This parallels what I'm seeing -- perhaps inode/dentry cache
|   bloat is causing the memory issue (which mimics if not _is_
|   a memory leak) _and_ my kswapd thrashing?  It fits both the
|   situation you report and what I'm seeing with I/O across a
|   large number of files (inodes) -- updatedb, smb, NFS, etc.
|
|   I think Andrea was on to this issue, so I'm hoping his work
|   will help.  Have you tried an -aa kernel or an aa patch onto
|   a 2.4.17-pre4 to see how the kernel's behavior changes?
|   
|   -- 
|   Ken.
|   brownfld@irridia.com

I get the exact same behavior with 2.4.17-pre4-aa1 - many applications
abort with ENOMEM after updatedb (filling the buffer and cache). Is
there another kernel/patch I should try?

Leigh Orf

