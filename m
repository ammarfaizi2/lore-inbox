Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277501AbRJJX2R>; Wed, 10 Oct 2001 19:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277528AbRJJX2H>; Wed, 10 Oct 2001 19:28:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36868 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277501AbRJJX2B>; Wed, 10 Oct 2001 19:28:01 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Dump corrupts ext2?
Date: 10 Oct 2001 16:28:24 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9q2lio$65c$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com>
By author:    Lew Wolfgang <wolfgang@sweet-haven.com>
In newsgroup: linux.dev.kernel
>
> Hi Folks,
> 
> I was looking for some scripts to backup ext2 partitions
> to multiple CDR's when I stumbled onto "cdbackup" at
> http://www.cableone.net/ccondit/cdbackup/.
> 
> Alas, there is a warning saying:
> 
> "WARNING! When using this program under Linux, be sure not to use
>  dump with kernels in the 2.4.x series. Using dump on an ext2
>  filesystem has a very high potential for causing filesystem
>  corruption.  As of kernel version 2.4.5, this has not been
>  resolved, and it may not be for some time."
> 
> I don't recall any problems like this, does anyone have
> additional comments?
> 

Not really surprising... doesn't dump expect to be able to read a rw
mounted filesystem by reading the raw device and get the data off it?
Doesn't work.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
