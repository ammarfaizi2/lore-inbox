Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278959AbRJ2Cnv>; Sun, 28 Oct 2001 21:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278960AbRJ2Cnb>; Sun, 28 Oct 2001 21:43:31 -0500
Received: from ns2.kvikkjokk.net ([195.196.65.62]:4365 "HELO ns2.kvikkjokk.net")
	by vger.kernel.org with SMTP id <S278959AbRJ2CnZ>;
	Sun, 28 Oct 2001 21:43:25 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Oden Eriksson <oden.eriksson@kvikkjokk.net>
Message-Id: <200110290339.02702@kvikkjokk.net>
To: linux-kernel@vger.kernel.org
Subject: Re: APM disable broken (was -> Re: 8139too on ABIT BP6 causes "eth0: transmit timed out" )
Date: Mon, 29 Oct 2001 03:43:56 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15xz5T-0008SA-00@trillium-hollow.org>
In-Reply-To: <E15xz5T-0008SA-00@trillium-hollow.org>
X-No-Archive: No
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mondayen den 29 October 2001 00.11, erich@uruk.org wrote:
> Raphael Manfredi <Raphael_Manfredi@pobox.com> wrote:
>
> ...[recent 2.4-based kernel]...
>
> > but this problem is not specific to that kernel.  I've been having
> > it for a looong time.
> >
> > Specifically, I get:
> >
> >  NETDEV WATCHDOG: eth0: transmit timed out
>
> ...
>
> > and then the machine is dead, network-wise.  I have to reboot (reset).
> >
> > Note that I am on an ABIT BP6 board, and I do get a lot of APIC errors
> > under heavy network traffic, which is what raises the above.
> > By heavy network traffic, I mean a 7 Mb/s full duplex (it's a 100 Mb/s
> > LAN).
>
> I had what looks like exactly this problem with my ABIT BP6 -based machine
> running RH 7.1, and the problem turned out to be the interaction between
> SMP and the APM BIOS, when APM is turned on.  A different network card,
> but the same symptom.  Another symptom I would occasionally see was a
> certain kind of hard-disk hang, but only on the integrated HPT366
> controller.

You might want to try the latest Abit BP6 "RU" bios with HPT366 bios v1.28, 
get it at:

ftp://ftp.mathematik.uni-marburg.de/pub/mirror/abit/beta/bp6/bios/128/bp6ru128.zip

Chears.

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
| Oden Eriksson, Deserve-IT Networks, Jokkmokk, Sweden.
| Mandrake Linux release 8.2 (Cooker) for i586
| Current uptime with kernel 2.4.12-6mdksmp: 14min
| cpu0 @ 814.28 bm, fan 4500 rpm, temp +31.0°C
| cpu1 @ 815.92 bm, fan 4500 rpm, temp +29°C
