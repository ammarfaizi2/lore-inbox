Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRHBEr0>; Thu, 2 Aug 2001 00:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268713AbRHBErQ>; Thu, 2 Aug 2001 00:47:16 -0400
Received: from quattro.sventech.com ([205.252.248.110]:54288 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S268712AbRHBErB>; Thu, 2 Aug 2001 00:47:01 -0400
Date: Thu, 2 Aug 2001 00:47:10 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: William T Wilson <fluffy@snurgle.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP possible with AMD CPUs?
Message-ID: <20010802004708.O3126@sventech.com>
In-Reply-To: <20010801161005.B784@sventech.com> <Pine.LNX.4.21.0108020032330.944-100000@benatar.snurgle.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0108020032330.944-100000@benatar.snurgle.org>; from fluffy@snurgle.org on Thu, Aug 02, 2001 at 12:34:54AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001, William T Wilson <fluffy@snurgle.org> wrote:
> On Wed, 1 Aug 2001, Johannes Erdfelt wrote:
> 
> > I don't know if this was true to begin with, but I know that SMP AMD
> > systems use the APIC SMP scheme Intel defined and uses.
> 
> Is this really true?  I seem to remember that there was very little
> difference between OPIC and APIC in the first place, but AMD could not use
> APIC because of licensing problems.
> 
> Since Athlons cannot use the same motherboards as Intel (unlike the K6-2)
> and AMD makes the SMP chipsets for Athlon, why would they possibly want to
> use APIC when they could more easily and cheaply use OPIC?

I'm pretty sure it's not identical since the APIC bus on GTL+ is most
likely different than the EV6 bus.

However, from a software point of view, they are pretty much identical
give or take a few implementation details (as seen in 2.2)

I don't know anything about OpenAPIC, so I can't say anything about the
similarities.

JE

