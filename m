Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTKZLEb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 06:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTKZLEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 06:04:31 -0500
Received: from mx1.elte.hu ([157.181.1.137]:55006 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262796AbTKZLE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 06:04:29 -0500
Date: Wed, 26 Nov 2003 10:59:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Demo patch - no interactivity 2.6
In-Reply-To: <200311241016.08990.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.58.0311261055280.17204@earth>
References: <200311241016.08990.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Nov 2003, Con Kolivas wrote:

> I created this patch for demonstration purposes.
> 
> People have raised concerns about the overhead of the interactivity
> estimator in 2.6 and it's effect on throughput. Some anecdotes report
> wild accusations of 20% loss (without hard data). [...]

this claim is nonsense, agreed. The only small change in performance
should be for microbenchmark things like lmbench's lat_ctx. But this cost
is well worth it.

	Ingo
