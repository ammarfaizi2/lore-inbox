Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRJYNvx>; Thu, 25 Oct 2001 09:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274255AbRJYNvn>; Thu, 25 Oct 2001 09:51:43 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:44554 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S274194AbRJYNv1>; Thu, 25 Oct 2001 09:51:27 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: concurrent VM subsystems
Date: Thu, 25 Oct 2001 06:52:23 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBOEPDDPAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0110251458020.6694-100000@Expansa.sns.it>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Luigi Genoni
> Sent: Thursday, October 25, 2001 6:07 AM
> To: Marton Kadar
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: concurrent VM subsystems


> In fact, here is the difference beetwen a coordinate and managed project,
> and the "lets' put all inside" approach.

No, it is the difference between an orderly, predictable, SEI - CMM type
development process used in military projects and the "brutal meritocracy",
Darwinian, survival of the fittest, life-at-the-edge-of-chaos process used
with Linux.

> That said.
> Those two VM are good, but for different use, and different HW.
> It is a choice also which main use the kernel should address as a target.
>
> I already exposed my opinion, and both Andrea and Rik know it very well.
> The VM for servers needs to be predictable, for desktops needs to be as
> fast as possible, also if it is a little less predictable and stable (who
> cares if you reboot you desktop once every two days?).

And I've given my opinion, though perhaps not quite as simply as I could. My
opinion is that there should be *one* VM (and *one* scheduler) *tunable* to
the purpose of the computer, rather than one which is good for a desktop,
another for a uniprocessor server, another for a few processors and another
for "massively parallel" servers. Just out of curiosity, which of the two
VMs is better for "predictable servers" and which one is better for "who
cares if you reboot" desktops?

> To have competition this way is also good, because there can also be
> cooperation and compenetration.

Yes ... the "life at the edge of chaos" I spoke of earlier. But in the end,
a single tunable algorithm would be preferable in my book to doing *two*
kernel builds and *two* boots every time one wanted to benchmark VM! One can
waste *weeks* doing this, when a single tunable algorithm could be optimized
to a benchmark or a real workload in *minutes*! Really! Just *minutes*, if
you do it right! It's about respect for the customer's time -- a concept
that needs to be considered along with all the exciting raw computer science
we're doing. :-)
--
M. Edward (Ed) Borasky, Borasky Research
Relax! Run Your Own Brain with Neuro-Semantics!
http://www.borasky-research.net/Flyer.htm
mailto:znmeb@borasky-research.net
http://groups.yahoo.com/group/pdx-neuro-semantics

Q: How do you tell when a pineapple is ready to eat?
A: It picks up its knife and fork.

