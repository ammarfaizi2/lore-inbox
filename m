Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293619AbSCPAnv>; Fri, 15 Mar 2002 19:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293625AbSCPAnl>; Fri, 15 Mar 2002 19:43:41 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:16912 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293619AbSCPAnc>; Fri, 15 Mar 2002 19:43:32 -0500
Date: Sat, 16 Mar 2002 01:43:26 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Stephen Samuel <samuel@bcgreen.com>
Cc: Robert Love <rml@tech9.net>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
Message-ID: <20020316014326.B31470@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Stephen Samuel <samuel@bcgreen.com>, Robert Love <rml@tech9.net>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <1015784104.1261.8.camel@phantasy> <20020311013853.A1545@devcon.net> <3C92704C.1070909@bcgreen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C92704C.1070909@bcgreen.com>; from samuel@bcgreen.com on Fri, Mar 15, 2002 at 02:06:04PM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 02:06:04PM -0800, Stephen Samuel wrote:
>  >
>  >     int sched_set_affinity(int which, int who, unsigned int len,
>  >                            unsigned long *new_mask_ptr);
>  >
>  > with who one of {PRIO_PROCESS,PRIO_PGRP,PRIO_USER} and which according
>  > to the value of who.

Uh, who/which should be just the other way round in the description
(but not in the prototype). Sorry.

> I soule suggest that the order be
> 
> int sched_set_affinity(int who, int which, unsigned int len,
>                              unsigned long *new_mask_ptr);
> 
> This would have the {p,pg}id be the first thing that a programmer
> would see (likely more important than the 'which'.).

See my correction above, does that address your concern?

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
