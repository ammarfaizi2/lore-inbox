Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283783AbRLWTS1>; Sun, 23 Dec 2001 14:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284010AbRLWTSR>; Sun, 23 Dec 2001 14:18:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31493 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283916AbRLWTSF>; Sun, 23 Dec 2001 14:18:05 -0500
Message-ID: <3C262DDC.1040103@zytor.com>
Date: Sun, 23 Dec 2001 11:17:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "T. A." <tkhoadfdsaf@hotmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple streams file)
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu> <3C25A06D.7030408@zytor.com> <OE15yZcIaeZ2FTVPuxT00007b64@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

T. A. wrote:

>     What about considering one of the simpler filesystems or archive formats
> instead?  How much "Unix"-ism is required to be retained in the archive?
> (permissions, device files, etc?)
> 


They're MUCH MUCH MUCH MUCH MUCH worse.  Don't even think abou it.


>     As for the bigendianness... Is it really relevant since each kernel is
> tied to its own platform?  And if it is may it be better to use the native
> format of the 98% or so of the Linux machines out there which are
> littleendian (performance and ease of general access on the majority of host
> machines comes to mind).


This was discussed recently... doing a nonportable format is begging for 
problems.  The only reason I'm suggesting bigendian is that conversion 
to bigendian macros are more widely available in the form of the 
standard hton macros.

	-hpa





