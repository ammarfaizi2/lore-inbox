Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312050AbSCZNrg>; Tue, 26 Mar 2002 08:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312124AbSCZNr1>; Tue, 26 Mar 2002 08:47:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14209 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312050AbSCZNrW>; Tue, 26 Mar 2002 08:47:22 -0500
Date: Tue, 26 Mar 2002 08:47:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Weinehall <tao@acc.umu.se>
cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
        Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: save_flags() should take unsigned long
In-Reply-To: <20020326142955.E16636@khan.acc.umu.se>
Message-ID: <Pine.LNX.3.95.1020326084541.5964A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2002, David Weinehall wrote:

> On Mon, Mar 04, 2002 at 07:46:53PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > ...and here's patch to fix it... Please apply.
> 
> The correct way to fix this would be:
> 
> <in suitable header-file; suggestions welcome>
> typedef flags_t unsigned long;

I don't think it takes an 'unsigned long'. Instead, it takes 'size_t'.
This makes it work in all architectures because 'size_t' is the
size of a register.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

