Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTFDI1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 04:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTFDI1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 04:27:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36497 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263176AbTFDI1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 04:27:16 -0400
Date: Wed, 4 Jun 2003 10:40:36 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-yoann@ifrance.com, linux-kernel@vger.kernel.org, vojtech@suse.cz,
       acahalan@cs.uml.edu
Subject: Re: another must-fix: major PS/2 mouse problem
Message-ID: <20030604104036.A5583@ucw.cz>
References: <1054431962.22103.744.camel@cube> <3EDD87FD.6020307@ifrance.com> <20030603232155.1488c02f.akpm@digeo.com> <20030604094737.C5345@ucw.cz> <20030604005302.41f3b0b8.akpm@digeo.com> <20030604100017.A5475@ucw.cz> <20030604011413.16787964.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030604011413.16787964.akpm@digeo.com>; from akpm@digeo.com on Wed, Jun 04, 2003 at 01:14:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 01:14:13AM -0700, Andrew Morton wrote:

> > > Has this problem been observed in 2.4 kernels?
> > 
> >  No, since 2.4 doesn't have the re-sync code in the mouse driver which is
> >  triggering in this case. But problems with the machine being flooded
> >  with interrupts from the NIC so hard that it actually cannot do anything
> >  are quite common.
> 
> So is the resync code doing more good than harm?

Hard to tell. The people for which it does good don't complain.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
