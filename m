Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSAXSWk>; Thu, 24 Jan 2002 13:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288801AbSAXSWA>; Thu, 24 Jan 2002 13:22:00 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:29100 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288859AbSAXSVL>; Thu, 24 Jan 2002 13:21:11 -0500
Message-Id: <5.1.0.14.2.20020124181848.00b23180@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 Jan 2002 18:22:03 +0000
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: RFC: booleans and the kernel
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:42 24/01/02, Jeff Garzik wrote:
>A small issue...
>
>C99 introduced _Bool as a builtin type.  The gcc patch for it went into
>cvs around Dec 2000.  Any objections to propagating this type and usage
>of 'true' and 'false' around the kernel?
>
>Where variables are truly boolean use of a bool type makes the
>intentions of the code more clear.  And it also gives the compiler a
>slightly better chance to optimize code [I suspect].
>
>Actually I prefer 'bool' to '_Bool', if this becomes a kernel standard.

I would be in favour of this as it does make code more readable. I use it 
in ntfs tng quite a bit (but I just typedef a BOOL type myself).

If it is added, then _please_ don't use '_Bool', that's just sick... 
'bool', heck even 'BOOL' would be better than that!

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

