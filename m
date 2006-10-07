Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932884AbWJGXFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932884AbWJGXFN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932885AbWJGXFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 19:05:13 -0400
Received: from main.gmane.org ([80.91.229.2]:21904 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932884AbWJGXFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 19:05:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH 05/10] -mm: clocksource: convert generic timeofday
Date: Sat, 7 Oct 2006 23:04:49 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrneigcmk.3o8.olecom@deen.upol.cz.local>
References: <20061006185439.667702000@mvista.com> <20061006185456.838445000@mvista.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.180.30
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On 2006-10-06, Daniel Walker wrote:
[]
> +int clocksource_sysfs_register(struct sysdev_attribute * attr)
[]
>  static int __init init_clocksource_sysfs(void)

it seems kernel/time/clocksource.c doesn't honor CONFIG_SYSFS at
all...

Maybe this option isn't needed any more ? It doesn't exist in
menuconfig, and i couldn't set in `n' manually.

[]
> @@ -17,6 +17,8 @@
>   *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
>   *                              Copyright (C) 2000, 2001, 2002  Ingo Molnar
>   *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
> + *  2006-08-03  Added usage of the generic clocksource API
> + *				Copyright (C) 2006 MontaVista, Daniel Walker
>   */

there are comments about having new source management system, thus, logs
on top are not needed any more...
  
-o--=O`C
 #oo'L O
<___=E M


