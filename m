Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265227AbSJRQJu>; Fri, 18 Oct 2002 12:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSJRQIm>; Fri, 18 Oct 2002 12:08:42 -0400
Received: from nameservices.net ([208.234.25.16]:57867 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265221AbSJRQIh>;
	Fri, 18 Oct 2002 12:08:37 -0400
Message-ID: <3DB034A7.D7E9BA78@opersys.com>
Date: Fri, 18 Oct 2002 12:19:51 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Takeharu Kato <tk1219@alles.or.jp>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [ltt-dev] [ANNOUNCE] LTT 0.9.6pre2: Per-CPU buffers, TSC timestamps, 
 etc.
References: <3DAF850D.D104A6D@opersys.com> <3DB03026.63AF250F@alles.or.jp>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Takeharu Kato wrote:
> Karim Yaghmour wrote:
> >
> > A new development version of LTT is now available, 0.9.6pre2.
> > Here's what's new:
> > - Per-CPU buffering
> > - TSC timestamping
> > - Use of syscall interface instead of char dev abstraction
> >
> As long as I think, 0.9.6pre2 has called CHAR DEV in LibUserTrace.
> Should I apply the patch which you send before?

0.9.6pre2 is a development version, it's expected to have rough
spots. If you need a stable version use 0.9.5a. That said, yes
LibUserTrace hasn't been modified yet for the syscall interface,
but this is really a minor issue which will be fixed.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
