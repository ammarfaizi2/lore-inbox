Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131001AbRAWM3v>; Tue, 23 Jan 2001 07:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131049AbRAWM3b>; Tue, 23 Jan 2001 07:29:31 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:26268 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131001AbRAWM3X>; Tue, 23 Jan 2001 07:29:23 -0500
Message-Id: <5.0.2.1.2.20010123122539.00a18c00@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 23 Jan 2001 12:29:17 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.0-ac10 compile errors 
Cc: Anders Karlsson <anders.karlsson@meansolutions.com>
In-Reply-To: <23997.980252378@ocs3.ocs-net>
In-Reply-To: <Your message of "Tue, 23 Jan 2001 12:16:11 -0000." <20010123121611.A3723@alien.ssd.hursley.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[recipient's list shortened]
At 12:19 23/01/01, Keith Owens wrote:
>On Tue, 23 Jan 2001 12:16:11 +0000,
>Anders Karlsson <anders.karlsson@meansolutions.com> wrote:
> >Even if it is a pristine kernel tree? What function does the 'make
> >mrproper' fill on an unused kernel tree?
>
>Depends on how you removed the old tree.  If you did 'rm -rf *' then
>some dot files are left around.  make mrproper removes dot files, it
>may or may not be the fix.

And don't forget that even "an unused kernel tree" installed from scratch 
can very well not be clean from generated files as well. I always do a make 
mrproper after I uncompressed a new kernel tree to make sure there are no 
files there that shouldn't be.

Anton


-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
