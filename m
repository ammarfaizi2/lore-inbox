Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265572AbSJRSvz>; Fri, 18 Oct 2002 14:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSJRSvp>; Fri, 18 Oct 2002 14:51:45 -0400
Received: from nameservices.net ([208.234.25.16]:29722 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265355AbSJRStb>;
	Fri, 18 Oct 2002 14:49:31 -0400
Message-ID: <3DB05A60.5D64425@opersys.com>
Date: Fri, 18 Oct 2002 15:00:48 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: frowand@mvista.com
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [ltt-dev] [ANNOUNCE] LTT 0.9.6pre2: Per-CPU buffers, TSC timestamps, 
 etc.
References: <3DAF850D.D104A6D@opersys.com> <3DB053C4.8458B0D8@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Frank Rowand wrote:
> I noticed that the Linux 2.4.19 patch is not carried forward from
> pre1 to pre2.  Are you planning to no longer maintain support for
> LTT in the Linux 2.4 line?

The problem is that the kernel patch is highly dependent on the kernel's
own development. The tracing infrastructure has to change as the kernel
changes. Incidently, the user tools also have to change to accomodate
the newer kernels. There's a point where keeping compatibility with
older kernels becomes increasingly difficult and would entail one of
two things:
- Burden the user tools with legacy support.
- Backport all new features to older kernels.

Neither of these is really interesting. Of course, if someone wants to
take the time to backport some of the new features to older kernels
I would gladly publish their patch with the tools. The time it takes
to work out an LTT patch is non-negligeable and I don't have the
bandwidth to maintain multiple kernel patches in parallel. This is
why I'm concentrating on getting LTT to work with the latest and
greatest.

Obviously things will be much simpler once the LTT patch is included
in the kernel.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
