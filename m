Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278450AbRKOL5v>; Thu, 15 Nov 2001 06:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRKOL5l>; Thu, 15 Nov 2001 06:57:41 -0500
Received: from chamber.cco.caltech.edu ([131.215.48.55]:52156 "EHLO
	chamber.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S278450AbRKOL5e>; Thu, 15 Nov 2001 06:57:34 -0500
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: LFS stopped working
Date: Thu, 15 Nov 2001 03:57:35 -0800
Message-ID: <JIEIIHMANOCFHDAAHBHOOEOOCMAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <howv0s48nx.fsf@gee.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I'm running Debian 2.2 (with a few recompiled newer packages, as well
as a recompiled glibc 2.1.3 obviously), which comes with bash 2.03.
Compiling & installing bash 2.05, and commenting out that line in
/etc/pam.d/ssh that was mentioned in the web page you provided unfortunately
didn't change anything - the ulimit for file size was still unlimited, and I
still couldn't write >2GB files.

Alex

-----Original Message-----
From: aj@suse.de [mailto:aj@suse.de]
Sent: Thursday, November 15, 2001 2:43 AM
To: Alex Adriaanse
Cc: linux-kernel@vger.kernel.org
Subject: Re: LFS stopped working


"Alex Adriaanse" <alex_a@caltech.edu> writes:

> But ulimit shows that the file size is unlimited... would this be a bug?
If
> that's the case, then how/why would it work before?

If you use an older distro, bash will not handle the changed getrlimit
syscall in 2.4, for details check the Red Hat entry under:
http://www.suse.de/~aj/linux_lfs.html

Andreas
--
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj

