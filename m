Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbTFCQxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbTFCQxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:53:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48893 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265101AbTFCQwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:52:25 -0400
Subject: Re: [BENCHMARK] 100Hz preempt v nopreempt contest results
From: Robert Love <rml@tech9.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <200306031639.49515.kernel@kolivas.org>
References: <200306031639.49515.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1054659956.633.85.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 03 Jun 2003 10:05:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 23:39, Con Kolivas wrote:

> Note this time the ratio is less useful since they are both 100Hz. The 
> difference this time shows a large preempt improvement in process_load much 
> like 1000Hz did. Interestingly, even unloaded kernels no_load and cache_load 
> runs are faster with preempt. Only in xtar_load (repeatedly extracting a tar 
> with multiple small files) was no preempt faster.

Thanks for running these, Con.

I think this is an example of kernel preemption doing exactly what we
want it to (improve interactive performance)... probably primarily
because of the more accurate timeslice distribution.

Would be interested to figure out why xtar_load is slower.

	Robert Love


