Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSCLWtF>; Tue, 12 Mar 2002 17:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293556AbSCLWsx>; Tue, 12 Mar 2002 17:48:53 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:16844 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S293181AbSCLWss>;
	Tue, 12 Mar 2002 17:48:48 -0500
Message-Id: <5.1.0.14.2.20020312224609.04e7aaf0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 12 Mar 2002 22:48:38 +0000
To: "H. Peter Anvin" <hpa@zytor.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: IO stats in /proc/partitions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a6lt8j$md6$1@cesium.transmeta.com>
In-Reply-To: <3C8E1FFF.9090705@linkvest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:51 12/03/02, H. Peter Anvin wrote:
>Followup to:  <3C8E1FFF.9090705@linkvest.com>
>By author:    Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
>In newsgroup: linux.dev.kernel
> >
> > Hi,
> > I use 2.4.19-pre2-ac4.
> > 2 questions:
> > - Either MD Raid ot LVM IO devices are not accounted in /proc/partitions
> > IO data. Is it normal?
> > - Are the new /proc/partitions IO stats integrated in 2.4.19-pre3?
> >
>
>If we're adding fields to /proc/partitions, I would like to
>*strongly* recommend that /proc/partitions adds the following
>information:
>
>         offset and length

I had a patch for this already. I can update it and resend if the powers 
that be want it. Just let me know...

Anton

>         parent device (if applicable)
>
>The latter could also be used to identify parallelizable devices
>(spindles) for things like fsck.
>
>         -hpa
>--
><hpa@transmeta.com> at work, <hpa@zytor.com> in private!
>"Unix gives you enough rope to shoot yourself in the foot."
>http://www.zytor.com/~hpa/puzzle.txt    <amsp@zytor.com>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

