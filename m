Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132757AbREGSDZ>; Mon, 7 May 2001 14:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132914AbREGSDQ>; Mon, 7 May 2001 14:03:16 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:53944 "EHLO
	phenoxide.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S132765AbREGSDB>; Mon, 7 May 2001 14:03:01 -0400
Date: Mon, 7 May 2001 11:02:50 -0700
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: Shane Wegner <shane@cm.nu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.20pre1: Problems with SMP
Message-ID: <20010507110250.H903@valinux.com>
In-Reply-To: <20010506175050.A1968@cm.nu> <E14wiNn-0003JF-00@the-village.bc.nu> <20010507102053.A2276@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010507102053.A2276@cm.nu>; from shane@cm.nu on Mon, May 07, 2001 at 10:20:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001, Shane Wegner <shane@cm.nu> wrote:
> On Mon, May 07, 2001 at 11:36:49AM +0100, Alan Cox wrote:
> > > Just booted up 2.2.20pre1 and am getting some funny
> > > results.  The system boots but is very slow.  Every few
> > > seconds I get:
> > > Stuck on TLB IPI wait (CPU#0)
> > > 
> > > Booting vanilla 2.2.19 works fine.  The machine is an
> > > Intel Pentium III 850MHZ on an Abit VP6 board.  If any
> > > further information is needed, let me know.
> > 
> > Can you back out the change to io_apic.c and tell me if that fixes it. If so
> > let Johannes Erdfelt and I know.
> 
> That does indeed correct the problem.  2.2.20pre1 now works
> as expected.

Hmm, that uses a VIA based chipset. I didn't know they did SMP yet. Does
2.4 work on this system?

JE

