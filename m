Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSFPSQg>; Sun, 16 Jun 2002 14:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSFPSQf>; Sun, 16 Jun 2002 14:16:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3859 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316491AbSFPSQf>; Sun, 16 Jun 2002 14:16:35 -0400
Date: Sun, 16 Jun 2002 11:16:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Osterlund <petero2@telia.com>
cc: Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
       Alessandro Suardi <alessandro.suardi@oracle.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <m2znxvbrir.fsf@ppro.localdomain>
Message-ID: <Pine.LNX.4.44.0206161115230.3316-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 Jun 2002, Peter Osterlund wrote:
>
> Sure, with an unpatched 2.5.21 kernel, bringing up eth0 fails during
> boot. Tobias Diedrich posted a one-line patch that fixes this problem
> for me:

Ok, that looks correct to me. Good.

> All tests I have done so far with 2.5.21 based kernels produce an oops
> at shutdown, which makes the machine hang instead of rebooting or
> powering off.

This is an IDE one - the IDE driver puts a device that it never got.

I'll do a 2.5.22 (with Tobias' fix too).

		Linus

