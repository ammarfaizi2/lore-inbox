Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSJPQa7>; Wed, 16 Oct 2002 12:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265170AbSJPQa7>; Wed, 16 Oct 2002 12:30:59 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:9745 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265169AbSJPQa5>; Wed, 16 Oct 2002 12:30:57 -0400
Date: Wed, 16 Oct 2002 17:36:54 +0100
From: John Levon <levon@movementarian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [4/7] oprofile - NMI hook
Message-ID: <20021016163654.GA85246@compsoc.man.ac.uk>
References: <20021015223319.GD41906@compsoc.man.ac.uk> <32233.1034777200@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32233.1034777200@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 12:06:40AM +1000, Keith Owens wrote:

> Both kdb and lkcd use cross cpu NMI for debugging and dumping on SMP.
> That plus oprofile and the NMI watchdog makes at least four users of
> NMI.  A one level hook is not going to cut it, it should be a list.
> 
> I admit that removal of a hook from the NMI list while still handling
> NMI interrupts is "interesting", but that is a SMOP ;).  RCU to the
> rescue?

Yep, now RCU is merged I'll read up and see if I can come up with a list
API

regards
john
-- 
"It's a cardboard universe ... and if you lean too hard against it, you fall
 through." 
	- Philip K. Dick 
