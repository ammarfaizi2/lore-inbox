Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283016AbRLWAmj>; Sat, 22 Dec 2001 19:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283048AbRLWAm3>; Sat, 22 Dec 2001 19:42:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49414 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283045AbRLWAm0>; Sat, 22 Dec 2001 19:42:26 -0500
Message-ID: <3C252861.3090600@zytor.com>
Date: Sat, 22 Dec 2001 16:42:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: dcinege@psychosis.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <Pine.GSO.4.21.0112180350550.6100-100000@weyl.math.psu.edu> <T57e612d0dbac1785e6169@pcow028o.blueyonder.co.uk> <9vo4b3$iet$1@cesium.transmeta.com> <E16HwgA-0001uk-00@schizo.psychosis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Cinege wrote:

> On Tuesday 18 December 2001 14:10, H. Peter Anvin wrote:
> 
> 
>>Note that Al is working on a replacement; he's not just bitching.  The
>>replacement is called "initramfs" which means populating a ramfs from
>>an archive or collection of archives passwd by the bootloader.  With
>>that in there, lots of things can be done in userspace.
>>
> 
> Already done for many months (actully years) now. If I thought it
> would be accepted, I'd gut rd.c and fully merge it into a 2.5 patch.
> 


Viro's going quite a bit beyond this, though.  Also, a big key is the 
ability to have multiple images, some of which may not be compressed.

	-hpa



