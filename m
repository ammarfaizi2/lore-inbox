Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281886AbRKWFOA>; Fri, 23 Nov 2001 00:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281984AbRKWFNw>; Fri, 23 Nov 2001 00:13:52 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:40105 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281886AbRKWFNn>; Fri, 23 Nov 2001 00:13:43 -0500
Date: Thu, 22 Nov 2001 22:13:50 -0700
Message-Id: <200111230513.fAN5Dov07626@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jack Howarth <howarth@nitro.med.uc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-floppy.c vs devfs
In-Reply-To: <200111110439.XAA53352@nitro.msbb.uc.edu>
In-Reply-To: <200111110439.XAA53352@nitro.msbb.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Howarth writes:
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

Is this an LS-120 drive? If so, I'm soon getting one, so I can finally
play with this.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
