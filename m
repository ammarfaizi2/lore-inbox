Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273979AbRISBVW>; Tue, 18 Sep 2001 21:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273981AbRISBVM>; Tue, 18 Sep 2001 21:21:12 -0400
Received: from adsl-66-122-62-224.dsl.sntc01.pacbell.net ([66.122.62.224]:2892
	"HELO top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S273979AbRISBU4>; Tue, 18 Sep 2001 21:20:56 -0400
From: brian@worldcontrol.com
Date: Tue, 18 Sep 2001 18:30:17 -0700
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Chris Vandomelen <chrisv@b0rked.dhs.org>, linux-kernel@vger.kernel.org,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Message-ID: <20010918183017.A6079@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Roberto Jung Drebes <drebes@inf.ufrgs.br>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Chris Vandomelen <chrisv@b0rked.dhs.org>,
	linux-kernel@vger.kernel.org,
	VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <Pine.GSO.4.21.0109140430540.2204-100000@jacui> <Pine.GSO.4.21.0109140523060.3130-100000@jacui> <20010915001530.A1594@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010915001530.A1594@top.worldcontrol.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried the 'Athlon Bug stomper #2 bit 7 patch version 1' on a 2nd
matchine, 900 MHz Duron system with an Epox 8KTA3+ MB, and it too
is now running fine with an Athlon optimized kernel, when before it
would oops to death on boot.

Shall I keep posting success reports or are people convinced this
fix works?

> > > On 13 Sep 2001, Eric W. Biederman wrote:
> > > > Anyone want to generate a kernel patch so this fix can get some wider
> > > > testing?
> 
> > On Fri, 14 Sep 2001, Roberto Jung Drebes wrote:
> > > I'll try to isolate the single bit in the register that is causing the
> > > fault and will send the diff.
> 
> On Fri, Sep 14, 2001 at 05:27:49AM -0300, Roberto Jung Drebes wrote:
> > I tested here and it seems that bit 7 is responsible. Here is the diff to
> > pci-pc.c:
> 
On Sat, Sep 15, 2001 at 12:15:30AM -0700, brian@worldcontrol.com wrote:
> I just tried the patch and for the first time I've been able to
> successfully boot and run a 2.4 kernel with Athlon optimizations.
> ...
> The machine that has been successful, and the only one I tried, is an
> 800 MHz Duron system with an Epox 8KTA3+ MB which is now running fine
> with linux 2.4.9ac10 + the Athlon Bug stomper #2 bit 7 patch version 1.


-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
