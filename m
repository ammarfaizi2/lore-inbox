Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261281AbREOT1F>; Tue, 15 May 2001 15:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbREOT0z>; Tue, 15 May 2001 15:26:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:42245 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261281AbREOT0o>; Tue, 15 May 2001 15:26:44 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Getting FS access events
Date: 15 May 2001 12:26:20 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9drvss$7pc$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0105150058370.22938-100000@p4.transmeta.com> <Pine.GSO.4.21.0105150424310.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0105150424310.19333-100000@weyl.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> UNIX-like ones (and that includes QNX) are easy. HFS is hopeless - it won't
> be fixed unless authors will do it. Tigran will probably fix BFS just as a
> learning experience ;-) ADFS looks tolerably easy to fix. AFFS... directories
> will be pure hell - blocks jump from directory to directory at zero notice.
> NTFS and HPFS will win from switch (esp. NTFS). FAT is not a problem, if we
> are willing to break CVF and let author fix it. Reiserfs... Dunno. They've
> got a private (slightly mutated) copy of ~60% of fs/buffer.c. UDF should be
> OK. ISOFS... ask Peter. JFFS - dunno.
> 

isofs wouldn't be too bad as long as struct mapping:struct inode is a
many-to-one mapping.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
