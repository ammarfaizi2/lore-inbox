Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131039AbRAPL5T>; Tue, 16 Jan 2001 06:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131043AbRAPL5J>; Tue, 16 Jan 2001 06:57:09 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:31498 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131039AbRAPL4x>; Tue, 16 Jan 2001 06:56:53 -0500
Date: Tue, 16 Jan 2001 05:56:48 -0600
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010116055647.A12650@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.30.0101152035090.5713-100000@elte.hu> <200101152033.f0FKXpv250839@saturn.cs.uml.edu> <20010116114018.A28720@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010116114018.A28720@convergence.de>; from leitner@convergence.de on Tue, Jan 16, 2001 at 11:40:18AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Felix von Leitner]
> I don't know how Linux does it, but returning the first free file
> descriptor can be implemented as O(1) operation.

How exactly?  Maybe I'm being dense today.  Having used up the lowest
available fd, how do you find the next-lowest one, the next open()?  I
can't think of anything that isn't O(n).  (Sure you can amortize it
different ways by keeping lists of fds, etc.)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
