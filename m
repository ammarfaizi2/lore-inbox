Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272531AbRH3Wa1>; Thu, 30 Aug 2001 18:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272532AbRH3WaS>; Thu, 30 Aug 2001 18:30:18 -0400
Received: from smtp.polymtl.ca ([132.207.4.11]:32774 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id <S272531AbRH3WaN>;
	Thu, 30 Aug 2001 18:30:13 -0400
Date: Thu, 30 Aug 2001 18:30:27 -0400 (EDT)
From: Tester <tester@videotron.ca>
X-X-Sender: <tester@TesterServ.TesterNet>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bizzare crashes on IBM Thinkpad A22e
In-Reply-To: <20010830195041.N1146@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.31.0108301824340.30696-100000@TesterServ.TesterNet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Its a 256 megs machine.. Celeron 800..
I tried using mem=255M or mem=200M and it did not change anything and
still crashed. The celeron A22e seems to have the same bios as the A21e...

Btw, I received it as part of a ThinkPad University program (laptop at
school) from IBM with the old mandrake installed. And they IS guy of the
university told us that they didnt install the latest released because IBM
had not approved it... IBM probably already knows of the problem... So a
message to IBM and IBMers: Why dont you fix your known bugs?

Also it works correctly in w2k, but win2k uses ACPI and not APM (and it
has a IBM pm driver...)

Tester
tester@videotron.ca

On Thu, 30 Aug 2001, Erik Mouw wrote:

> On Thu, Aug 30, 2001 at 11:46:19AM -0400, Tester wrote:
> > I've just received an IBM Thinkpad A22e. Using kernel 2.4.2-2 (redhat 7.1
> > version) or the stock 2.4.4 or 2.4.9 (they all exhibit the same problem).
>
> Uh-oh, another broken Thinkpad BIOS.
>
> > When I use any of the APM functions or any of the thinkpad keys (volume
> > keys and Fn-Fx keys.. for suspend and even display brightness), the whole
> > system freezes without any other indication. This is using a kernel with
> > APM compiled it, but without any other option. If I compile in ACPI
> > instead of APM, it freezes even before the kernel is done booting. But, it
> > worked perfectly well with the 2.2.19-2 kernel form Mandrake 7.2
>
> Hmm, linux-2.2.19pre4 got the "thinkpad E820 edx overwriting" for a
> Thinkpad 600X from Marc Joosen. The same fix also went into
> 2.4.0-test13-pre6, so that can't be the problem.
>
> > Everything else seems to work fine... can anyone help?
>
> Could you try to boot with "mem=one MB less than the machine actually
> has" and see if that fixes the problem? So "mem=127M" for a 128MB
> machine. If that fixes the problem, I think there is a bug in the e820
> BIOS memory map and you should ask IBM to fix their BIOS.
>
>
> Erik
>
> --
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
>

