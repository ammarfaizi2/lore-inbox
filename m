Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312859AbSDEOlh>; Fri, 5 Apr 2002 09:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312861AbSDEOl1>; Fri, 5 Apr 2002 09:41:27 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:17905 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312859AbSDEOlM>; Fri, 5 Apr 2002 09:41:12 -0500
Message-Id: <5.1.0.14.2.20020405153618.01fefd20@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 05 Apr 2002 15:41:28 +0100
To: "Arnvid Karstad" <arnvid@karstad.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Problems rebooting from linux to windows...
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020405130948.17108.qmail@nextgeneration.speedroad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:09 05/04/02, Arnvid Karstad wrote:
>recently I've seen a few problems with several laptops and if one are so 
>unfortunate that one needs to reboot into Windows after a session in linux.
>Normal restart of windows never have a problem on the same machines, but 
>if you go from Linux to for instance Windows by shutdown -r or reboot it 
>will freeze half way into the booting process.
>A power cycle will hower fix this.
>Anyone got an idea about where to start looking?

The Microsoft Windows sourcecode would be a good start but oh wait you 
can't get that. D'oh! You are fscked! Just power cycle and as you have seen 
you will be fine.

The reason for the problems is that Windows is expecting the hardware to be 
in a certain state at boot which is not present after Linux reboots because 
it has initialized the devices differently.

On my laptop the reverse is true. When rebooting from Windows to Linux 
XFree86 no longer works (garbled display) but power cycling is fine. I 
could look into this and force the hardware to reinitialize in Linux or I 
could just power cycle. I chose the power cycle as I have better things to 
do...

But in your case the way to fix this would be to make the windows driver 
initialize the hardware properly and I doubt very much you would have much 
success getting MS to do this for you. They will probably tell you to stop 
using Linux and your problems will go away...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

