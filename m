Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVGTAXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVGTAXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 20:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVGTAXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 20:23:11 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49657 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261684AbVGTAXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 20:23:10 -0400
Subject: Re: Interbench real time benchmark results
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
In-Reply-To: <200507200816.11386.kernel@kolivas.org>
References: <200507200816.11386.kernel@kolivas.org>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 19 Jul 2005 17:23:03 -0700
Message-Id: <1121818983.26927.74.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-20 at 08:16 +1000, Con Kolivas wrote:

> Interestingly the average latencies are slightly higher (in the miniscule <2us 
> range), but the maximum latencies are excellently bound to 25us.
> 
> The results are quite reproducible.

I would guess that the average latencies are tunable .. In this case if
any of the benchmarks are dependent on specific interrupts , or
ksoftirqd, you can tune the priority of the associate IRQ threads , or
ksoftirqd, to get similar averages to 2.6.12 ..

Daniel

