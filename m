Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273752AbRIQXIP>; Mon, 17 Sep 2001 19:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273750AbRIQXIG>; Mon, 17 Sep 2001 19:08:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38160 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273749AbRIQXHy>; Mon, 17 Sep 2001 19:07:54 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Reading Windows CD on Linux 2.4.6
Date: 17 Sep 2001 16:08:10 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9o5voq$21d$1@cesium.transmeta.com>
In-Reply-To: <E15j68m-0007wc-00@the-village.bc.nu> <3BA6791A.616636CE@MissionCriticalLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3BA6791A.616636CE@MissionCriticalLinux.com>
By author:    Bruce Blinn <blinn@MissionCriticalLinux.com>
In newsgroup: linux.dev.kernel
> 
> I do not think the disk is missing data or that there are any bad
> blocks.  The reason I say this is because I can access every file on the
> disk when the CD is mounted as an iso9660 file system on a 2.2.19
> kernel.  I compared the files with the originals and they are identical.
> 
> The only reason I found out dd would not copy the disk is because Masoud
> asked for an image.
> I tried using dd to copy a much larger CD (150 Mb) and it fails at the
> same place and the resulting file is the same size (737280 bytes).  So
> it fails long before the end of the data.
> 
> By the way, dd works fine when copying other CDs that were not created
> under Windows.
> 

This almost seems to imply they're recording the data noncontiguously,
which would be totally bizarre but not totally impossible.

      -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
