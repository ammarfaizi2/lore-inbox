Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276397AbRJPRHs>; Tue, 16 Oct 2001 13:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276411AbRJPRHi>; Tue, 16 Oct 2001 13:07:38 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:47374 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S276397AbRJPRH1>; Tue, 16 Oct 2001 13:07:27 -0400
Date: Tue, 16 Oct 2001 18:07:57 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: GPLONLY kernel symbols???
Message-ID: <20011016180757.A78456@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0110160927030.24895-100000@devel.office>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110160927030.24895-100000@devel.office>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 09:27:55AM -0700, Christoph Lameter wrote:

> /lib/modules/2.4.11/kernel/drivers/block/loop.o: Note: modules without a
> GPL compatible license cannot use GPLONLY_ symbols
> 
> What is THAT?

A symbol that may only be referenced by GPL code.

The solution here is to add MODULE_LICENSE("GPL") into loop.c (probably)
or upgrade (assuming it's fixed later).

regards
john

p.s. upgrade anyway, 2.4.11 is a bad idea ...

-- 
"I hear you have four hundred and eighty six PCs for sale ?"
	- Some Fool 
