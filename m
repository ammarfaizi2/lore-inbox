Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262237AbREXTh0>; Thu, 24 May 2001 15:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262238AbREXThQ>; Thu, 24 May 2001 15:37:16 -0400
Received: from quattro.sventech.com ([205.252.248.110]:43022 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S262237AbREXThH>; Thu, 24 May 2001 15:37:07 -0400
Date: Thu, 24 May 2001 15:36:54 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Prasanna P Subash <psubash@turbolinux.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon on 2.2.19 ?
Message-ID: <20010524153653.A26439@sventech.com>
In-Reply-To: <20010522182740.A3125@turbolinux.com> <E152toh-0004uo-00@the-village.bc.nu> <20010524123030.B3485@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010524123030.B3485@turbolinux.com>; from Prasanna P Subash on Thu, May 24, 2001 at 12:30:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001, Prasanna P Subash <psubash@turbolinux.com> wrote:
> I have a dual athlon on the 760MP chipset.
> 2.2.20pre1 and 2 dont work. I got it to work partly after applying Johannes
> Erdfel's 760MP patch in io_apic.c. Even after applying the patch, there
> are messages like

2.2.20pre1 and pre2 both have the patch I created already applied. If
you had to apply them yourself then something is wrong.

> hdc: IRQ probe failed(0)
> hdd: IRQ probe failed(0)
> hde: IRQ probe failed(0)
> 
> hdc: lost interrupt
> hdc: lost interrupt
> 
> and then the machine hangs randomly. I an guessing the io_apic does not
> route the interrupts correctly.

That would be the problem.

Which patch of mine did you apply? Which motherboard are you doing your
testing with?

JE

