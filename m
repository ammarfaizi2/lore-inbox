Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281283AbRLDRA3>; Tue, 4 Dec 2001 12:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRLDQ7B>; Tue, 4 Dec 2001 11:59:01 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:9411 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S279927AbRLDQ6N>; Tue, 4 Dec 2001 11:58:13 -0500
Date: Tue, 4 Dec 2001 09:57:26 -0700
Message-Id: <200112041657.fB4GvQV06981@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 AudioCD with cdrom modules
In-Reply-To: <3C0CC182.B65B6A52@wanadoo.fr>
In-Reply-To: <3C0CC182.B65B6A52@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet writes:
> What may cause an AudioCD no being recocognized at first attempt but
> only after unloading/reloading the modules ide-cd cdrom ?
> 
> I'm testing 2.5.1-pre5 + devfs-patch-v202.
> 
> My CRD-8240B is known as /dev/cdroms/cdrom0 in fstab, to mount it
> manually on /cdrom, and in the gnome CD player gtcd preferences panel.
> 
> ide-cd and cdrom are loaded at boot time (i don't need that, 2.4.16 does
> it as well). After loging in i can mount /cdrom but if it is an AudioCD
> gtcd tells me 'no disc'.
> 
> After rmmod ide-cd cdrom, gtcd finds the AudioCD OK.
> 
> This doesn't happen on plain 2.4.16

Please try kernel 2.4.17-pre2 + devfs-patch-v199.2. That will help
determine if the problem is devfs-related, or (more likely) due to the
block I/O changes happening in 2.5.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
