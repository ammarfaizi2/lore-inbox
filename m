Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286261AbSAMPhg>; Sun, 13 Jan 2002 10:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286297AbSAMPh0>; Sun, 13 Jan 2002 10:37:26 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:11404 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S286261AbSAMPhO>;
	Sun, 13 Jan 2002 10:37:14 -0500
Date: Sun, 13 Jan 2002 15:36:02 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020113153602.GA19130@fenrus.demon.nl>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <3C41A545.A903F24C@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C41A545.A903F24C@linux-m68k.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 04:18:29PM +0100, Roman Zippel wrote:

> What somehow got lost in this discussion, that both patches don't
> necessarily conflict with each other, they both attack the same problem
> with different approaches, which complement each other. I prefer to get
> the best of both patches.

If you do this (and I've seen the results of doing both at once vs only
either of then vs pure) then there's NO benifit for the preemption left.
Sure AVERAGE latency goes down slightly, however this is talking in the usec
range since worst case is already 1msec or less. Below the 1msec range it
really doesn't matter anymore however. 

At that point you're adding all the complexity for the negliable-to-no-gain
case...

Greetings,
   Arjan van de Ven
