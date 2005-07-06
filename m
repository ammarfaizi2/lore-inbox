Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVGFSAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVGFSAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVGFSAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:00:22 -0400
Received: from [203.171.93.254] ([203.171.93.254]:21379 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262086AbVGFNU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:20:28 -0400
Subject: Re: [PATCH] [25/48] Suspend2 2.1.9.8 for 2.6.12: 602-smp.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f0205070605036e673d5e@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164422727@foobar.com>
	 <84144f0205070605036e673d5e@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120656110.4860.331.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 23:21:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 22:03, Pekka Enberg wrote:

[snip]

> > +#define SUSPEND_SINGLESTEP             10
> > +#define SUSPEND_PAUSE_NEAR_PAGESET_END 11
> > +#define SUSPEND_USE_ACPI_S4            12
> > +#define SUSPEND_KEEP_METADATA          13
> > +#define SUSPEND_TEST_FILTER_SPEED      14
> > +#define SUSPEND_FREEZE_TIMERS          15
> > +#define SUSPEND_DISABLE_SYSDEV_SUPPORT 16
> > +#define SUSPEND_VGA_POST               17
> > +
> > +#define TEST_ACTION_STATE(bit) (test_bit(bit, &suspend_action))
> > +#define SET_ACTION_STATE(bit) (test_and_set_bit(bit, &suspend_action))
> > +#define CLEAR_ACTION_STATE(bit) (test_and_clear_bit(bit, &suspend_action))
> 
> Enums, please.

Done. I'm off to bed now. Don't think I'm ignoring the rest :>

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

