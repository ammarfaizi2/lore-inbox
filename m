Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQKLAT0>; Sat, 11 Nov 2000 19:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKLATS>; Sat, 11 Nov 2000 19:19:18 -0500
Received: from slc644.modem.xmission.com ([166.70.7.136]:37895 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129234AbQKLATH>; Sat, 11 Nov 2000 19:19:07 -0500
To: Adam Lazur <alazur@progeny.com>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <3A0ABB0C.99075A61@holly-springs.nc.us> <m1k8aacmvo.fsf@frodo.biederman.org> <20001111174632.A17737@progenylinux.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2000 17:06:49 -0700
In-Reply-To: Adam Lazur's message of "Sat, 11 Nov 2000 17:46:32 -0500"
Message-ID: <m17l6acaue.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Lazur <alazur@progeny.com> writes:

> Eric W. Biederman (ebiederm@xmission.com) said:
> > Michael Rothwell <rothwell@holly-springs.nc.us> writes:
> > > This would rock. One place I can think of using it is with distro
> > > installers. The installer boots a generic i386 kernel, and then installs
> > > an optimized (i.e, PIII, etc.) kernel for run-time.
> > 
> > This would rock?  It already does.  Of course the installers need
> > to actually uses this.
> 
> Actually, along the lines of what Scyld uses two kernel monte for with
> their Beowulf2 distribution.
> 
> They boot a network enabled kernel which pulls a kernel off of a server
> and then uses two kernel monte to boot with that one.  This allows you
> to centrally admin your cluster with one server. Good stuff...

Yep.  You can also do this with etherboot flashed on one a nick card as well.

I also intend to use my work for this functionality as well.  
FYI I work for linux networx which builds hardware for linux clusters.

The fact that Scyld is using arp and a fixed network socket is a 
design decision I don't agree with.   

Truly slick will be when linuxBIOS is solid.  Then you even get remote
control of the BIOS, and remote booting all from within the BIOS.  Only
time will tell if it is worth the effort :)

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
