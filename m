Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289517AbSAVWxc>; Tue, 22 Jan 2002 17:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289514AbSAVWxN>; Tue, 22 Jan 2002 17:53:13 -0500
Received: from smtp010.mail.yahoo.com ([216.136.173.30]:43531 "HELO
	smtp010.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289521AbSAVWww> convert rfc822-to-8bit; Tue, 22 Jan 2002 17:52:52 -0500
From: Steve Brueggeman <xioborg@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon PSE/AGP Bug
Date: Tue, 22 Jan 2002 16:52:50 -0600
Message-ID: <c5qr4uk3adm53fgvuibld2tnjtnfnq0a5i@4ax.com>
In-Reply-To: <1011610422.13864.24.camel@zeus> <20020121.053724.124970557.davem@redhat.com> <20020121.053724.124970557.davem@redhat.com> <20020121175410.G8292@athlon.random> <3C4C5B26.3A8512EF@zip.com.au> <o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com> <hbep4uka8q6t1tfv6694sjtvfrulipg3a4@4ax.com>  <87k7uakutl.fsf@CERT.Uni-Stuttgart.DE> <1011737673.10474.12.camel@psuedomode>
In-Reply-To: <1011737673.10474.12.camel@psuedomode>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, now my dander's beginning to get up.

I have been in the computer industry for 20+ years.  

I don't particularily like graphic interfaces.  

My original post said that I was running the kernel compile in console
mode, but I guess I didn't expressly state that there was "NO X
running".  

I did state that there were no Frame Buffer modules, nor DRM modules
loaded, but I did have the AGPGART driver for the SiS AGP hardware
compiled into the kernel.

I am not overclocking my system in "ANY WAY SHAP OR FORM".  I do not
believe one bit in overclocking, as I appreciate stability much more
than the 2% to 5% overclocking gets you. 

I have PC2100 DDR SDRAM, which should be able to run with a 133 Mhz
bus. 

I have an Athelon 1800+ (1500 or so real clock) which should run with
1 133Mhz bus.

While I cannot rule out a poor power supply, experience has shown me
that a minor tweek, such as running the kernel with mem=nopentium, is
not enough of a load change to expose a bad power supply.

Again, I reiterate, I consistently got 3-4 Segmentation faults when
compiling a kernel without the mem=nopentium, with 5 attempts done.

I was unable to get any segfaults when compiling kernels WITH the
mem=nopentium option, with 10 attempts done.

I AM NOT stating that this is necessarily the Athelon bug exposed by
gentoo, but it appears that there are enough people complaining about
unstable systems, becoming stable by running with the mem=nopentium.
It also appears that a significant number of them are also running
Nvidia AGP graphics adapters.  

For all I know, this may be due to Nvidia imposing some border-spec
timming on the AGP bus when doing dma, or maybe it could be Athelon
related, or maybe it could in fact be a kernel bug that's been blown
off by kernel developers, just because they're using Nvidia, and don't
bother to ask whether or not they were running X or not.  

And of course, since this is a new, and untested system, purchased
from a computer fair, it could indeed be bad hardware, it's just that
my current indications say it's not.

I would like to see some indication that someone is collecting data
related to "running stable with mem=nopentium on Athelon
architecture", and maybe we can see a pattern here.  Heck maybe we see
2 or 3 different patterns here.

OK, I'm done.

Steve Brueggeman



On 22 Jan 2002 17:14:27 -0500, you wrote:

>On the same note.  Anyone trying to run their ram faster than it should
>go from the bios would eventually see these kind of things happen. I
>used to get errors from anything really memory intensive, games and such
>from having ram set at cas 2 instead of cas 3 and removing certain
>delays when i shouldn't.  People should really make sure their tuned up
>systems aren't just overtuned before forking up segfaults to the Athlon
>bug that apparently all the kernel guru's have decided doesn't affect
>linux just as it doesn't affect the bsd people.   
>
>It seems to me that the bug "could" be in your chip, it doesn't mean
>it's in every athlon...  otherwise we'd be seeing some commonalities and
>so far i've seen none.  
>
>Since all the people having problems in linux with the athlon bug are
>heavy graphics/game users ...I'd suspect overtuning as the problem
>before anything else first and make sure they run memtest86,  even if
>disabling pentium ops fixes things. 
>


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

