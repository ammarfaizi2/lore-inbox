Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265352AbSJRThn>; Fri, 18 Oct 2002 15:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265345AbSJRThn>; Fri, 18 Oct 2002 15:37:43 -0400
Received: from nameservices.net ([208.234.25.16]:54046 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265352AbSJRThl>;
	Fri, 18 Oct 2002 15:37:41 -0400
Message-ID: <3DB065AC.A18F1BD@opersys.com>
Date: Fri, 18 Oct 2002 15:49:00 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Niels Provos <provos@citi.umich.edu>, LTT-Dev <ltt-dev@shafik.org>
CC: linux-kernel@vger.kernel.org, marius@umich.edu
Subject: Re: systrace for linux
References: <20021018191057.GJ1704@citi.citi.umich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Niels,

This is the sort of facility which can easily go on top of the existing
LTT infrastructure (http://www.opersys.com/LTT) since most of the events
you need are already cleanly caught by LTT. If we'd reintegrate the
event callback mechanisms we removed on Ingo Molnar's request (albeit
exporting them as GPLonly this time), systrace would then be easily
maintained as a loadable kernel module. In addition, since LTT already
has appropriate hooks for 6 architectures, systrace would immediately
become available on those archs (i386, PPC, S/390, ARM, MIPS, SH).

Karim

Niels Provos wrote:
> Marius A. Eriksen just finished the Linux port of systrace.  You can
> find the kernel patch at
> 
>   http://www.citi.umich.edu/u/provos/systrace/linux.html
> 
> Systrace is a fine grained sandbox for applications and system services.
> It supports interactive policy generation, intrusion detection, policy
> enforcement, privilege elevation, etc.  More information at
> 
>   http://www.citi.umich.edu/u/provos/systrace/
> 
> Comments are appreciated.

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
