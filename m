Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270319AbRHWUoD>; Thu, 23 Aug 2001 16:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270314AbRHWUnn>; Thu, 23 Aug 2001 16:43:43 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:35971 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S270319AbRHWUnl>;
	Thu, 23 Aug 2001 16:43:41 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Bob Glamm <glamm@mail.ece.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
In-Reply-To: <20010822030807.N120@pervalidus> <20010823140555.A1077@newton.bauerschmidt.eu.org> <20010823103620.A6965@kittpeak.ece.umn.edu> <20010823085900.F14302@cpe-24-221-152-185.az.sprintbbd.net> <d3k7zutw5y.fsf@lxplus051.cern.ch> <20010823124109.S14302@cpe-24-221-152-185.az.sprintbbd.net> <d3g0aituio.fsf@lxplus051.cern.ch> <20010823131348.Y14302@cpe-24-221-152-185.az.sprintbbd.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 23 Aug 2001 22:43:46 +0200
In-Reply-To: Tom Rini's message of "Thu, 23 Aug 2001 13:13:48 -0700"
Message-ID: <d3bsl6tsl9.fsf@lxplus051.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

Tom> On Thu, Aug 23, 2001 at 10:02:07PM +0200, Jes Sorensen wrote:
>>  I am actually much more concerned about bringing up new systems
>> than embedded however it is not uncommon to have very limited space
>> to work in (like 64MB).

Tom> 64mb of space for 'disk' ?  You aren't compiling the kernel
Tom> anyhow without some serious mucking around.

You may keep your binaries in flash on system like that.

>> My point is that the transport process of the kernel image is
>> painful. Some of the embedded devices or new systems being brought
>> up may only have serial some do not have network or floppy. This
>> makes it *very* painful to move things around because you have to
>> physically move your disk or similar.

Tom> And you think that trying to transport the kernel srcs + userland
Tom> will save you time in the long run?  If you have to physically
Tom> move your disk to initially put userland on, you can put on
Tom> python too.  Or go and run the 'freeze' schitt on it and have the
Tom> C version.  What kind of 'new' systems are you talking about?
Tom> I'm biased I guess since I'm used to working on documented
Tom> hardware.  So documents + time + good hw debugger tend to help
Tom> things along.

What I am saying is that I do *not* want to transport source
etc. every time I want to make a kernel change. And no I *cannot* just
put Python on it if I a) don't have the space or b) haven't brought up
Python on the system yet.

I am not speaking of any new systems I am working on right now, I am
speaking from my experience bringing up systems such as the m68k and
ia64.

Tom> Because with the exception of your unique situation in which you
Tom> have a machine which is stable enough to compile a kernel on and
Tom> develop but can't run python, it's not a problem.

As I have pointed out, it *is* indeed a problem to kernel developers
who are actually working on bringing up systems. Most of the people
who argue in favor of the Python dependency have never tried bringing
up a system.

Jes
