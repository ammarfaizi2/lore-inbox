Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTFYP2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTFYP2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:28:12 -0400
Received: from dm2-58.slc.aros.net ([66.219.220.58]:5808 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264546AbTFYP2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:28:08 -0400
Message-ID: <3EF9C2D8.5060801@aros.net>
Date: Wed, 25 Jun 2003 09:42:16 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Peloquin <peloquin@austin.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linstab <linstab@osdl.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
Subject: Re: [Fwd: [BENCHMARK] 2.5.73, -bk1, -bk2, -mm1 regression results]
References: <3EF9BF57.5090309@austin.ibm.com>
In-Reply-To: <3EF9BF57.5090309@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Peloquin wrote:

> Nightly Regression Summary
> for
> 2.5.72 vs 2.5.73
>
>
> Benchmark         Pass/Fail   Improvements   Regressions       
> Results       Results   Summary
> ---------------   ---------   ------------   -----------   
> -----------   -----------   -------
>
> dbench.ext2           P            N              N             
> 2.5.72        2.5.73    report
> dbench.ext3           P            Y              N             
> 2.5.72        2.5.73    report
> dbench.jfs            P            N              N             
> 2.5.72        2.5.73    report
> dbench.reiser         P            N              N             
> 2.5.72        2.5.73    report
> dbench.xfs            P            N              N             
> 2.5.72        2.5.73    report
> kernbench             P            N              N             
> 2.5.72        2.5.73    report
> lmbench               P            Y              Y             
> 2.5.72        2.5.73    report
> rawiobench            P            N              Y             
> 2.5.72        2.5.73    report
> specjbb               P            Y              Y             
> 2.5.72        2.5.73    report
> specsdet              P            N              Y             
> 2.5.72        2.5.73    report
> tbench                P            Y              N             
> 2.5.72        2.5.73    report
> tiobench.ext2         P            N              N             
> 2.5.72        2.5.73    report
> tiobench.ext3         P            Y              Y             
> 2.5.72        2.5.73    report
> tiobench.jfs          P            N              N             
> 2.5.72        2.5.73    report
> tiobench.reiser       P            Y              Y             
> 2.5.72        2.5.73    report
> tiobench.xfs          P            N              Y             
> 2.5.72        2.5.73    report
> volanomark            P            N              N             
> 2.5.72        2.5.73    report
>
> http://ltcperf.ncsa.uiuc.edu/data/2.5.73/2.5.72-vs-2.5.73/
>
> Nightly Regression Summary
> for . . .

Wow! This is impressive. I'd love to see this include performance of 
ext3 (or jfs) over NBD (network block device) too. Or at least 
performance metrics like this for NBD some other way. I've done some 
benchmarking myself for the work I've been doing on NBD but nothing near 
this comprehensive. If someone had the spare time to do this though for 
NBD, it'd help me enormously. Any interest??? :-)

