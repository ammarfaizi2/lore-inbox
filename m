Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129113AbQKKWrA>; Sat, 11 Nov 2000 17:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129442AbQKKWqv>; Sat, 11 Nov 2000 17:46:51 -0500
Received: from PM3Naxs12-218.naxs.com ([216.98.81.218]:23306 "HELO
	london.progenylinux.com") by vger.kernel.org with SMTP
	id <S129113AbQKKWqk>; Sat, 11 Nov 2000 17:46:40 -0500
Date: Sat, 11 Nov 2000 17:46:32 -0500
From: Adam Lazur <alazur@progeny.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
Message-ID: <20001111174632.A17737@progenylinux.com>
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <3A0ABB0C.99075A61@holly-springs.nc.us> <m1k8aacmvo.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1k8aacmvo.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Nov 11, 2000 at 12:46:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman (ebiederm@xmission.com) said:
> Michael Rothwell <rothwell@holly-springs.nc.us> writes:
> > This would rock. One place I can think of using it is with distro
> > installers. The installer boots a generic i386 kernel, and then installs
> > an optimized (i.e, PIII, etc.) kernel for run-time.
> 
> This would rock?  It already does.  Of course the installers need
> to actually uses this.

Actually, along the lines of what Scyld uses two kernel monte for with
their Beowulf2 distribution.

They boot a network enabled kernel which pulls a kernel off of a server
and then uses two kernel monte to boot with that one.  This allows you
to centrally admin your cluster with one server. Good stuff...

.adam

-- 
[ Adam Lazur, NOW Monkey                          <alazur@progeny.com> ]
[ Progeny Linux Systems                             http://progeny.com ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
