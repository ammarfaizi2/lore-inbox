Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSIXXNG>; Tue, 24 Sep 2002 19:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbSIXXNG>; Tue, 24 Sep 2002 19:13:06 -0400
Received: from nameservices.net ([208.234.25.16]:37044 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S261842AbSIXXNF>;
	Tue, 24 Sep 2002 19:13:05 -0400
Message-ID: <3D90F3AC.84AFDE93@opersys.com>
Date: Tue, 24 Sep 2002 19:22:20 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] Adeos nanokernel for 2.5.38 1/2: no-arch code
References: <3D8E8371.D2070D87@opersys.com> <20020922045907.C35@toy.ucw.cz> <3D90D388.746D0C0D@opersys.com> <20020924220607.GD1496@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Machek wrote:
> Are you actually able to use Adeos for something reasonable?

Sure, see below.

> You can't
> run two copies of linux, because they would fight over memory; right?

Currently we can't, you're right. But I've already detailed how to do
this in a paper I wrote last july on how to obtain Linux SMP clusters
with as few modifications to the kernel as possible. The paper is
available on the web:
http://opersys.com/ftp/pub/Adeos/practical-smp-clusters.ps
(If you stil can't access the web as said in the other email, I can
send you a copy off-list if you want.)

> Do you have something that can run alongside linux?

Certainly. According to some reports it's already used in some commercial
systems and, as today's RTAI announcement reads, it will be the basis
for the next release of RTAI.

What we need now is ports to other architectures than the i386. This
should be fairly simple for anyone familiar enough with the Linux
interrupt layer for any other arch.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
