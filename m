Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbSIXPzV>; Tue, 24 Sep 2002 11:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSIXPzV>; Tue, 24 Sep 2002 11:55:21 -0400
Received: from nameservices.net ([208.234.25.16]:17037 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S261377AbSIXPzU>;
	Tue, 24 Sep 2002 11:55:20 -0400
Message-ID: <3D908D2A.C169D01B@opersys.com>
Date: Tue, 24 Sep 2002 12:04:58 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: Announce: rtai-24.1.10]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For those on the LKML interested in RTAI:

Paolo Mantegazza wrote:
> Hi,
> 
> at: www.aero.polimi.it/~rtai you'll find "rtai-24.1.10".
> 
> It is a huge one, worth a couple of releases before it. There are so
> many new things that I'm not sure to recall them all. More or less and
> without caring of any order of presentation what's new should be:
> 
> - NEWLXRT, i.e. LXRT without using RTAI proper tasks. It schedules just
> LINUX tasks and kernel threads natively. Under NEWLXRT kernel space
> threads works in hard mode always, user space Linux tasks can be
> soft/hard as in LXRT. You can think of it as something that makes Linux
> a hard real time kernel natively, albeit under the constraint of using
> RTAI APIs. Anything that runs under RTAI can run under NEWLXRT
> (kernel/user space). Back portable down to rtai-24.1.7 by just copying
> the related directory.
> 
> - Full support for writing interrupt handlers in user space under
> LXRT/NEWLXRT (UserSpaceInterrups-USI).
> 
> - Support for COMEDI kernel space APIs (kcomedilib) in user space under
> LXRT/NEWLXRT, in soft/hard real time. (The Comedi Players)
> 
> - Support for LABVIEW under LXRT/NEWLXRT, in soft/hard real time. It is
> now possible to program your hard real time applications, including
> interrupt handlers, using the visual 'G' language. (Thomas Leibner)
> 
> - LXRT extensions can now use the FPU. (Giuseppe Renoldi)
> 
> - A new real time support for serial ports, user/kernel space (SPDRV).
> (Giuseppe Renoldi)
> 
> - Support for making it easy for you to prepare a bootable floppy that
> runs RTAI (uRTAI, read it microRTAI). (Lorenzo Dozio)
> 
> - RTW should work more reliably and has more DAQ boards supported,
> including NI-MIO line. (Lorenzo Dozio)
> 
> - Revised and more detailed configuration for a better making. (Lorenzo
> Dozio, with help and suggestions from the RTAI team)
> 
> It is also possible to apply a new patch (allsoft) that allows
> configuring RTAI to manage all interrupts (hard/soft), in the soft way
> (ALLSOFT) and avoid scheduling any RTAI proper tasks from Linux
> (MINI_LXRT). The new configuration making will assist you in setting up
> such features, if you use the "allsoft" patch.
> 
> It is distributed as a short living provisional work.
> 
> In fact ALLSOFT+MINI_LXRT is meant to pave the way to the ADEOS
> transition by statically mimicking its multi-domain scheme in
> replacement of the previous master(RTAI)-slave(Linux) approach. It is
> intended to provide the bottom line in terms of performance that we
> should be able to reach, hopefully improve, with ADEOS, so people can
> immediately experiment the implications of the future transition to
> ADEOS. Such a transition will be the core of rtai-24.1.11.
> 
> I'll not dwell on the meaning of having ALLSOFT+MINI_LXRT and NEWLXRT
> (back portable), RTAI users should grasp it easily.
> 
> Paolo Mantegazza.
