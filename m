Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSH0EoY>; Tue, 27 Aug 2002 00:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSH0EoY>; Tue, 27 Aug 2002 00:44:24 -0400
Received: from flash.lakeheadu.ca ([192.75.62.101]:44428 "EHLO
	flash.lakeheadu.ca") by vger.kernel.org with ESMTP
	id <S313563AbSH0EoX>; Tue, 27 Aug 2002 00:44:23 -0400
Message-ID: <3D6B04AD.1050000@bonin.ca>
Date: Tue, 27 Aug 2002 00:48:45 -0400
From: Andre Bonin <kernel@bonin.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, fr-ca
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Loop devices under NTFS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I don't know if this is kernel-related.

I'me trying to mount my redhat iso's off an NTFS mount but I get a 
strange error.  Here is the exact command I am entering:

"mount -o loop -r -t iso9660 /mnt/win_d/Source/Iso/Red\ Hat\ 
7.3/valhalla-i386-disc1.iso /mnt/rh7.3/cd1"

It gives me an error
"ioctl: LOOP_SET_FD: Invalid argument"

A quick grep found that "Invalid argument" comes from:
'acsi.c:322:     { 0x24, "Invalid argument" }'

This might sound silly but I can't really seem to track it down.
Yes loop devices are enabled in my kernel.

It might interest you that I am running an SMP system (with the AMD 
controller).  But I don't think that should affect anything at such a 
higher level... You never know.

Anyone have any ideas?

Thanks!


*******************************
Andre Bonin
Student in Software Engineering
Lakehead University
Thunder Bay, Ontario
Canada
*******************************


