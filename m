Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281147AbRKYWFU>; Sun, 25 Nov 2001 17:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281146AbRKYWFL>; Sun, 25 Nov 2001 17:05:11 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:17967 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S281144AbRKYWE4>; Sun, 25 Nov 2001 17:04:56 -0500
Message-ID: <3C016B85.7040207@paulbristow.net>
Date: Sun, 25 Nov 2001 23:07:01 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jack Howarth <howarth@nitro.med.uc.edu>
CC: linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: ide-floppy.c vs devfs
In-Reply-To: <200111110439.XAA53352@nitro.msbb.uc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Try the devfs test version that I just uploaded to

http://paulbristow.net/linux/idefloppy.html

This is early days, and I'm not sure what the best approach is...

Feedback is greatly appreaciated.

Jack Howarth wrote:

> Paul,
>    Is ide-floppy supposed to be devfs friendly? I ask
> because on Linux 2.4.15-pre2 (and previous kernels)
> on the Powermac (Debian ppc sid) I find that the
> ide-floppy driver only creates device for my ide 
> zip if a zip disk is inserted at boot time. Otherwise
> the /dev/ide/host1/bus0/target1/lun0 directory doesn't
> contain a device node for the zip whereas the ide-cdrom
> driver creates a /dev/ide/host1/bus0/target0/lun0/cd
> fine without a cdrom disk inserted at boot time. I find
> that the only way I can get the zip device created at
> boot time without media inserted is to use ide-scsi 
> emulation and turn off ide-floppy when I configure the
> kernel. Is this issue a known problem and does it
> exist for other arches than powerpc (Powermac)? Thanks
> in advance for any advice.
>                       Jack
> ------------------------------------------------------------------------------
> Jack W. Howarth, Ph.D.                                    231 Albert Sabin Way
> NMR Facility Director                              Cincinnati, Ohio 45267-0524
> Dept. of Molecular Genetics                              phone: (513) 558-4420
> Univ. of Cincinnati College of Medicine                    fax: (513) 558-8474
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 

Paul

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

