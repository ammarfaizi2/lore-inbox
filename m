Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130438AbRBWVLy>; Fri, 23 Feb 2001 16:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130476AbRBWVLo>; Fri, 23 Feb 2001 16:11:44 -0500
Received: from brule.borg.umn.edu ([160.94.232.10]:49746 "EHLO
	brule.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S130438AbRBWVLd>; Fri, 23 Feb 2001 16:11:33 -0500
From: Peter Bergner <bergner@borg.umn.edu>
Date: Fri, 23 Feb 2001 15:34:47 -0600
To: Peter Samuelson <peter@cadcamlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Boot log for Linux PPC64 on POWER3 hardware
Message-ID: <20010223153447.A537283@brule.borg>
In-Reply-To: <3A95AB71.FCECB41F@us.ibm.com> <20010223001402.A19464@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20010223001402.A19464@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
: Impressive.  One question, though --
: 
: > starting cpu /cpus/PowerPC,POWER3@1...ok
: > starting cpu /cpus/PowerPC,POWER3@2...ok
: > starting cpu /cpus/PowerPC,POWER3@3...ok
: 
: You have 4 CPUs?
: 
: > OpenPIC Version 1.2 (8 CPUs and 32 IRQ sources) at e000000001002000
: > OpenPIC timer frequency is 0 MHz
: 
: ...or is it 8 CPUs?
: 
: > swamsauger:~ # uname -a
: > Linux swamsauger 2.4.0-tg11 #188 Thu Feb 22 19:55:45 CST 2001 ppc64 unknown
: > swamsauger:~ # 
: > swamsauger:~ # cat /proc/cpuinfo 
: > processor       : 0
: 
: ...or just one CPU?

Olaf pretty much answered all your questions.  Yes we are running a
non-SMP kernel at the moment, but even non-SMP kernels need to place
an SMP's unused processors in a spin loop so they don't play havoc
with the system.

Peter

--
Peter Bergner
SLIC Optimizing Translator Development / Linux PPC64 Kernel Development
IBM Rochester, MN
bergner@us.ibm.com

