Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262176AbRE2OHg>; Tue, 29 May 2001 10:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbRE2OH0>; Tue, 29 May 2001 10:07:26 -0400
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:6916 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S262176AbRE2OHP>;
	Tue, 29 May 2001 10:07:15 -0400
Date: Tue, 29 May 2001 10:07:13 -0400
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Subject: Re: Status of ALi MAGiK 1 support in 2.4.?
Message-ID: <20010529100713.A3845@saturn.tlug.org>
Mail-Followup-To: Mike Frisch <mfrisch@saturn.tlug.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Bobby D. Bryant" <bdbryant@mail.utexas.edu>
In-Reply-To: <3B12DCCF.6524A99@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B12DCCF.6524A99@mail.utexas.edu>; from bdbryant@mail.utexas.edu on Tue, May 29, 2001 at 05:18:39AM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 05:18:39AM +0600, Bobby D. Bryant wrote:
> sailing ever since.  The only problems that I'm are ware of are a
> (maybe) DMA problem and a (maybe) SMBus problem, per below.  Right now

I noticed the Win32 benchmark/test application Sandra mentioned an SMBus
problem with the A7A266 as well.  I have yet to try lm_sensors myself,
but it looks like I won't get far.

> May 22 21:45:07 pollux kernel: ALI15X3: IDE controller on PCI bus 00 dev
> 20
> May 22 21:45:07 pollux kernel: PCI: No IRQ known for interrupt pin A of
> device 00:04.0. Please try using pci=biosirq.

I get the same message, but it does not appear to dramatically affect
my performance.  As I mentioned, I am getting 25MB/s (through hdparm; I
have yet to try anything more) with my Quantum Fireball.  My DMA is
enabled in the BIOS and detected by the kernel.

> The routing to IQR 0 sounds funny to me, but this is already way beyond
> what I understand.

Do you have the PnP operating system setting in the BIOS turned off?
(ie. telling the BIOS you have non-PnP aware O/S)  I noticed that prior
to doing this, all of my PCI cards were listed as IRo 0.

Mike.
