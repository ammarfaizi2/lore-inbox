Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281846AbRKWCQS>; Thu, 22 Nov 2001 21:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281862AbRKWCQI>; Thu, 22 Nov 2001 21:16:08 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:19668 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281846AbRKWCP7>; Thu, 22 Nov 2001 21:15:59 -0500
Message-Id: <5.1.0.14.2.20011123020459.0707dcd0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 23 Nov 2001 02:16:04 +0000
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [vojkan@global.net.mt: Re: RAW NTFS Partition]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011122200146.A2427@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:01 23/11/01, Jeff V. Merkey wrote:
>Can you help this person?

I will reply to him off line. Sounds to me he is in desperate need of a 
data recovery company not of diskedit... Using diskedit on his part can 
damage the volume even more and if it is a whole year worth of work paying 
a few thousand dollars to get the data recovered is peanuts... If he 
insists then I will help him of course but I think it's a bad idea.

>My 18 months has now expired.  I can help on NTFS now if you need some help.

That's cool to know. I am developing a new NTFS driver - NTFS TNG. It is 
read-only for now and it is almost complete with regards to basic read 
support. I.e. it works NOW. - The only thing that is missing is attribute 
list attribute support but I am working on it as we speak. (-;

If you or anyone else of course is interested in participating in 
development, have a look. Code is in module ntfs-driver-tng in Sourceforge 
linux-ntfs CVS. URL with cvs access details:

         http://sourceforge.net/cvs/?group_id=13956

Note that the module requires some small changes to the core kernel and the 
appropriate patch is maintained in ntfs-driver-tng/patches directory. 
Currently kernel 2.4.15-pre4 is supported but patch might apply to later 
-pres as well.

After applying the patch and installing the new NTFS module sources NTFS 
TNG is completely separate from the kernel tree (all code including headers 
is in fs/ntfs and nowhere else and the include/linux/fs.h dependencies are 
gone).

One word of warning: NTFS TNG requires gcc-2.96 or later to compile. It 
will NOT compile with earlier versions of gcc! You will just get a million 
or so errors if you try any earlier gcc compiler...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

