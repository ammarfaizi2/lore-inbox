Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289306AbSA1Rw4>; Mon, 28 Jan 2002 12:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289298AbSA1Rwq>; Mon, 28 Jan 2002 12:52:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8578 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S289301AbSA1Rw1>; Mon, 28 Jan 2002 12:52:27 -0500
Date: Mon, 28 Jan 2002 12:55:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Nigel Gamble <nigel@nrg.org>
cc: Alex Davis <alex14641@yahoo.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Don't use dbench for benchmarks
In-Reply-To: <Pine.LNX.4.40.0201280852420.11243-100000@cosmic.nrg.org>
Message-ID: <Pine.LNX.3.95.1020128125322.17770A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Nigel Gamble wrote:

> On Mon, 28 Jan 2002, Richard B. Johnson wrote:
> > It seems that compiling the Linux Kernel while burning a CDROM gives
> > a good check of "acceptable" performance. But, such operations are
> > not "benchmarks". The trick is to create a benchmark that performs
> > many "simultaneous" independent and co-dependent operations using
> > I/O devices that everyone is likely to have. I haven't seen anything
> > like this yet.
> >
> > Such a benchmark might have multiple tasks performing things like:
> >
> > (1)	Real Math on large arrays.
> >
> > (2)	Data-base indexed lookups.
> >
> > (3)	Data-base keys sorting.
> >
> > (4)	Small file I/O with multiple creations and deletions.
> >
> > (5)	Large file I/O operations with many seeks.
> >
> > (6)	Multiple "network" Client/Server tasks through loop-back.
> >
> > (7)	Simulated compiles by searching directory trees for
> > 	"include" files, reading them and closing them, while
> > 	performing string-searches to simulate compiler parsing.
> >
> > (8)	Two or more tasks communicating using shared-RAM. This
> > 	can be a "nasty" performance hog, but tests the performance
> > 	of threaded applications without having to write those
> > 	applications.
> >
> > (9)	And more....
> >
> >
> > These tasks would be given a "performance weighting value", a heuristic
> > that relates to perceived overall performance.
> 
> It sounds like you are describing the Aim Benchmark suite, which has
> been used for years to compare unix system performancem, and was
> recently released under the GPL by Caldera.
> 
> See http://caldera.com/developers/community/contrib/aim.html
> 
> Nigel Gamble                                    nigel@nrg.org
> Mountain View, CA, USA.                         http://www.nrg.org/
> 

That sounds good. Have you tried it? Does it seem to provide the
kind of data that will show the effect of various trade-offs?



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


