Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUFPTEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUFPTEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUFPTEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:04:38 -0400
Received: from web51809.mail.yahoo.com ([206.190.38.240]:22203 "HELO
	web51809.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264627AbUFPTDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:03:20 -0400
Message-ID: <20040616190320.75156.qmail@web51809.mail.yahoo.com>
Date: Wed, 16 Jun 2004 12:03:20 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1087333441.40cf6441277b5@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,

I would like to try this against a 2.6.7 now that it
is out.  I am assuming the 267-rc3 patch will not go
nicely against a 2,6.7, so is there any way to update
this patch set?

Thanks!
Phy

--- Con Kolivas <kernel@kolivas.org> wrote:
> Here is an updated version of the staircase
> scheduler. I've been trying to hold
> off for 2.6.7 final but this has not been announced
> yet. Here is a brief update
> summary.
> 
>
http://ck.kolivas.org/patches/2.6/2.6.7-rc3/patch-2.6.7-rc3-s6.E
> 
> 
> Changes:
> 
> A lot more code from the original scheduler not
> required by staircase has been
> removed (610 deletions, 223 additions).
> 
> The "compute" mode now also includes cache trash
> minimisation by introducing
> delayed preemption. A task of higher priority will
> force a reschedule after a
> task has run a minimum of cache_decay_ticks. This
> increases the latency
> slightly but optimises cpu cache utilisation.
> 
> The yield() implementation was fixed to ensure it
> yielded to all other tasks.
> 
> Tiny cleanups elsewhere.
> 
> 
> Stability of this version has been confirmed in a
> number of different settings
> for days.
> 
> Testing, comments welcome.
> Con
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
