Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316780AbSGLSvA>; Fri, 12 Jul 2002 14:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSGLSu7>; Fri, 12 Jul 2002 14:50:59 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:32664 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316780AbSGLSu4>; Fri, 12 Jul 2002 14:50:56 -0400
Message-Id: <5.1.0.14.2.20020712194731.044115f0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 12 Jul 2002 19:54:37 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: IDE/ATAPI in 2.5
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D2F20DD.1030704@zytor.com>
References: <Pine.LNX.4.44.0207121050230.14359-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:33 12/07/02, H. Peter Anvin wrote:
>Linus Torvalds wrote:
>>On Fri, 12 Jul 2002, Martin Dalecki wrote:
>>
>>>So Linus what's your opinnion please?
>>
>>I will violently oppose anything that implies that the IDE layer uses the
>>SCSI layer normally.  No way, Jose. I'm all for scrapping, but the thing
>>that should be scrapped is ide-scsi.
>>The higher layers already have much of what the SCSI layer does, and the
>>SCSI layer itself is slowly moving in that direction.
>
>Then *please* make a *compatible* interface available to user space. This 
>certainly can be done; the parallel port IDE interface stuff had exactly 
>such an interface (/dev/pg*) -- we could have a /dev/hg* interface 
>presumably.  That is an acceptable solution.

But Linus is wanting exactly that! As far as I understand, Linus would like 
a generic interface sitting at the higher layers, and that is used by the 
ide/atapi/scsi layers. I read this as implying that the user space 
interface will also be only one. It will talk to the higher layers, the 
lower layers can then do all the hw specific magic.

Just my 2p.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

