Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136514AbREGSTI>; Mon, 7 May 2001 14:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136516AbREGSSt>; Mon, 7 May 2001 14:18:49 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:54967 "EHLO
	phenoxide.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S136514AbREGSSl>; Mon, 7 May 2001 14:18:41 -0400
Date: Mon, 7 May 2001 11:18:22 -0700
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: Shane Wegner <shane@cm.nu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.20pre1: Problems with SMP
Message-ID: <20010507111822.I903@valinux.com>
In-Reply-To: <20010506175050.A1968@cm.nu> <E14wiNn-0003JF-00@the-village.bc.nu> <20010507102053.A2276@cm.nu> <20010507110250.H903@valinux.com> <20010507111436.A17314@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010507111436.A17314@cm.nu>; from shane@cm.nu on Mon, May 07, 2001 at 11:14:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001, Shane Wegner <shane@cm.nu> wrote:
> On Mon, May 07, 2001 at 11:02:50AM -0700, Johannes Erdfelt wrote:
> > On Mon, May 07, 2001, Shane Wegner <shane@cm.nu> wrote:
> > > 
> > > That does indeed correct the problem.  2.2.20pre1 now works
> > > as expected.
> > 
> > Hmm, that uses a VIA based chipset. I didn't know they did SMP yet. Does
> > 2.4 work on this system?
> 
> The last 2.4 kernel I tried was 2.4.3 I believe and it
> worked fine more or less.  I haven't tried any later 2.4
> kernels yet.

That's fine. The I/O APIC code is different and I tried to make the 2.2
code work like the 2.4 code with minimal changes. However, the changes
aren't trivial. I'll take a quick look and see if I can find any more
significant differences.

I wonder if I have a VIA board laying around here.

JE

