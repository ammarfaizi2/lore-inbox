Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283388AbRLDVZl>; Tue, 4 Dec 2001 16:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281268AbRLDVZb>; Tue, 4 Dec 2001 16:25:31 -0500
Received: from [206.98.161.198] ([206.98.161.198]:19471 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S283469AbRLDVZV>; Tue, 4 Dec 2001 16:25:21 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
From: Edward Muller <emuller@learningpatterns.com>
To: Robert Love <rml@tech9.net>
Cc: =?ISO-8859-1?Q?Ra=FAlN=FA=F1ez?= de Arenas Coronado 
	<raul@viadomus.com>,
        esr@thyrsus.com, linux-kernel@vger.kernel.org
In-Reply-To: <1007496450.16169.20.camel@phantasy>
In-Reply-To: <E16BKL5-0001yJ-00@DervishD.viadomus.com> 
	<1007495452.4621.7.camel@akira.learningpatterns.com> 
	<1007496450.16169.20.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 16:23:06 -0500
Message-Id: <1007500986.4621.13.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-04 at 15:07, Robert Love wrote:
> On Tue, 2001-12-04 at 14:50, Edward Muller wrote:
> 
> > I've put python on my Compaq IPAQ (running linux) and with very few
> > amounts of tweaks it took up less 1 MB. And that's including gtk
> > bindings (no tk though) and just about the entire standard python
> > library. Someone else tried to do this with perl and they couldn't get
> > it under 3 MB IIRC. And IIRC, the current kernel build system requires
> > perl (I could be wrong, I'm just a watcher on this list, not a hacker).
> > So ... PYTHON IS NOT BLOATED.
> 
> No, it doesn't require Perl.  Its sh along with the standard Linux
> toolset.  xconfig is Tk, but not binded to Perl.
> 
> Regardless, I don't look at bloat as the issue -- who configures and
> compiles their kernel on an embedded device?  More specifically, it is
> what the kernel hackers have available and want to use that is the
> requirement.  This is partly why the whole "now your mom can easily
> configure her kernel" is a bs argument to me.  Forget my mom..._I_ want
> things a certain way.  My mom, if I ever forc^H^H^H^H get her to use
> Linux, will surely use the distro's kernel.
> 
> 	Robert Love

Re: Perl ...My BAD ... I though someone somewhere listed that perl was a
requirement for building the kernel, but looking at
Documentation/Changes I see I was wrong. In fact Documentation/Changes
already lists 10 necessary packages under the "Minimal Requirements"
section. Anyway ... 

I've been watching the whole CML1 vs. CML2 thing over the past year or
so and I don't think it's ever been about making it easy for a
neophite(sp) to configure their kernel. It's been about the fact that
CML1 is difficult/impossible to maintain in it's current state. I think
the choice was either to fix CML1 (language and tools) or come up with
something new. ESR decided to do the later and picked a tool that he
knew could get the job done. I'd almost bet their wouldn't have been as
much fuss over it if he had chosen perl, instead of python, but that's
just me being biased and cynical (Read: Ignore the comment.)

ESR could have written the CML2 implimentation in assembler, but decided
against it for various portability, code reuse/understandability,
simplicity, etc, etc, etc, reasons (I'll let Eric list them all if he
likes).

And .. Re: configuring a kernel on an embedded device... Well a few
people do actually. :-) I haven't done a lot with my iPAQ recently, but
there were bunches of people configuring and compiling their kernel's on
their ipaq (via nfs, IBM udrive, CF card, etc) last time I was heavily
involved. I was using the iPAQ as a way to illustrate that it's (python)
not all that big and it can fit on a small, embedded device.

And I agree, your Mom, my Mom and their friends, when linux comes to
their computer will use the the kernel that distro X gave them and will
probably never, ever even worry about it. Unless people like you and me
go to their house and upgrade it for them. :-) 


-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

