Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUHCHpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUHCHpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUHCHps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:45:48 -0400
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:40115 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265275AbUHCHph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:45:37 -0400
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org>
Message-ID: <cone.1091519122.804104.9648.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Date: Tue, 03 Aug 2004 17:45:22 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas writes:

> Nick Piggin writes:
> 
>> Con Kolivas wrote:
>>> Andrew Morton wrote:
>> 
>>> Anyone with feedback on this please cc me. This was developed separately 
>>> from the -mm series which has heaps of other scheduler patches which 
>>> were not trivial to merge with so there may be teething problems. Good 
>>> reports dont hurt either ;)
>>> 
>> 
>> I can't get onto the OSDL site now, but I seem to remember staircase
>> having some performance problems on a few things. Hackbench and reaim
>> from memory... are these fixed? was I dreaming?
> 
> Definitely dreaming I'm afraid :D
> 
> The performance on both reaim and hackbench has always equalled or exceeded 
> mainline so thanks for bringing it up.

Funny I just happen to have a few stored results which the urls do work for. 
Reaim normally on 8x with the default options gets about 7500-7700 jobs per 
minute. 

Here are the links for 2.6.8-rc2-mm2 with default setting:
Peak load Test: Maximum Jobs per Minute 
8248.40 (average of 3 runs) 
Quick Convergence Test: Maximum Jobs per 
Minute 7723.62 (average of 3 runs) 
http://khack.osdl.org/stp/295657/ 

in non interactive mode: 
Peak load Test: Maximum Jobs per Minute 
8379.02 (average of 3 runs) 
Quick Convergence Test: Maximum Jobs per 
Minute 7922.50 (average of 3 runs) 
http://khack.osdl.org/stp/295658/

and in compute mode:
Peak load Test: Maximum Jobs per Minute 8590.94 (average of 3 runs) 
Quick Convergence Test: Maximum Jobs per Minute 8294.81 (average of 3 runs)
http://khack.osdl.org/stp/295659/

Con

