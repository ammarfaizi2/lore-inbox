Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbTFRR7U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 13:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265472AbTFRR7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 13:59:20 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:58379 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265471AbTFRR7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 13:59:16 -0400
Subject: Re: [Bug 827] New: System time runs too fast.
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <10940000.1055947324@[10.10.2.4]>
References: <10940000.1055947324@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1055959989.586.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jun 2003 20:13:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 16:42, Martin J. Bligh wrote:
>            Summary: System time runs too fast.
>     Kernel Version: 2.5.72
>             Status: NEW
>           Severity: normal
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: ialiashkevich@epo.org
> 
> 
> Distribution:
> 
> Hardware Environment:
> Notebook Maxdata Eco 3000X
> Processor: P4 2Gz
> Chipset: SIS650
> 
> Software Environment:
> RedHat 8.0 + kernel 2.5.70
> RedHat 9.0 + kernel 2.5.72
> kernels were built by gcc 3.2.3 using default .config from arch/i386
> 
> Problem Description:
> System time runs at least twice faster than necessary.
> As a result have problems with keyboard timings:
>    very short delay before repeat mode and very fast repeat rate
> problems with mouse:
>    very fast double-click speed
>    
> Steps to reproduce:
>   buld, install kernel and restart :)

BTW, are you using CPU frequency scaling? While playing with my P4's CPU
frequency scaling, lowering the CPU frequency below a threshold
frequency value (below 1.4GHz approx.), the system starts acting
erratically: the keyboard generates event at twice or three times the
normal speed iiitttsss nnneeeaaarrrlllyyy iiimmmpppooosssiiibbbllleee to
type anything. The system clock starts skewing at a really fast pace and
the mouse is unusable. The only solution is returning the CPU frequency
to a higher value.

