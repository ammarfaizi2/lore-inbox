Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBURpo>; Wed, 21 Feb 2001 12:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRBURpe>; Wed, 21 Feb 2001 12:45:34 -0500
Received: from host217-32-138-113.hg.mdip.bt.net ([217.32.138.113]:62983 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129392AbRBURp3>;
	Wed, 21 Feb 2001 12:45:29 -0500
Date: Wed, 21 Feb 2001 17:48:21 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Burton Windle <burton@fint.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Detecting SMP
In-Reply-To: <Pine.LNX.4.21.0102201912150.16545-100000@fint.staticky.com>
Message-ID: <Pine.LNX.4.21.0102211746330.2050-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, just run the famous mptable program. If the machine is SMP then it
will have a valid Intel MP 1.4 configuration tables so the program will
show meaningful output.

Regards,
Tigran

On Tue, 20 Feb 2001, Burton Windle wrote:

> Hello. Is there a way, when running a non-SMP kernel, to detect or
> otherwise tell (software only; the machine is 2400 miles away) if the
> system has SMP capibilties? Would /proc/cpuinfo show two CPUs if the
> kernel is non-SMP?  Thanks!
> 
> (btw, the kernel in question is a stock RH6.2 kernel 2.2.14-5, and yes, I 
> know I should update it anyways and that a SMP kernel will run on a UP
> system)
> 
> 

