Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318730AbSHWK3f>; Fri, 23 Aug 2002 06:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318734AbSHWK3f>; Fri, 23 Aug 2002 06:29:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5393 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318730AbSHWK3f>; Fri, 23 Aug 2002 06:29:35 -0400
Date: Fri, 23 Aug 2002 11:33:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cell-phone like keyboard driver anywhere?
Message-ID: <20020823113344.B20722@flint.arm.linux.org.uk>
References: <200208210932.36132.h.schurig@mn-logistik.de> <200208230954.11132.h.schurig@mn-logistik.de> <20020823103151.A19858@flint.arm.linux.org.uk> <200208231205.28764.h.schurig@mn-logistik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208231205.28764.h.schurig@mn-logistik.de>; from h.schurig@mn-logistik.de on Fri, Aug 23, 2002 at 12:05:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry, but I find what you just did extremely offensive.  I
specifically did not copy lkml with my reply.  You therefore have
no right to copy bits from my reply and post them to a public forum.

On Fri, Aug 23, 2002 at 12:05:28PM +0200, Holger Schurig wrote:
> > The problems that need to be resolved with the kernel approach.  Lets
> > look at the '1-1-1' case:
> >
> > 1. Do you queue the characters "a" "^h" "b" "^h" "c" ?
> 
> There is no '1-1-1' case, the case is '1-1-1-pause'. Only after the pause 
> would the software (may it be kernel or user-space) know that and what 
> character has been meant. At the '1-1-1' state the user might press again a 1 
> and then wait, then this might be an '1-pause' case.
> 
> The idea is that in the case of '1-1-1-pause' the driver queues exactly one 
> character, e.g. the "c".

Where is the user feedback normally associated with the action of
pressing "1-1-1-pause" ?  Most keypads I know display "a" then "b"
then "c" so the user knows what character they're going to get.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

