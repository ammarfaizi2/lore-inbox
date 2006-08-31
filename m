Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWHaFVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWHaFVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 01:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWHaFVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 01:21:08 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:50758 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751048AbWHaFVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 01:21:05 -0400
Message-ID: <44F671BE.6000607@bigpond.net.au>
Date: Thu, 31 Aug 2006 15:21:02 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: balbir@in.ibm.com, Martin Ohlin <martin.ohlin@control.lth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: A nice CPU resource controller
References: <44F5AB45.8030109@control.lth.se>	 <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>	 <44F6365A.8010201@bigpond.net.au> <1157007190.6035.14.camel@Homer.simpson.net>
In-Reply-To: <1157007190.6035.14.camel@Homer.simpson.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Thu, 31 Aug 2006 05:21:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Thu, 2006-08-31 at 11:07 +1000, Peter Williams wrote:
> 
>> But your implication here is valid.  It is better to fiddle with the 
>> dynamic priorities than with nice as this leaves nice for its primary 
>> purpose of enabling the sysadmin to effect the allocation of CPU 
>> resources based on external considerations.
> 
> I don't understand.  It _is_ the administrator fiddling with nice based
> on external considerations.  It just steadies the administrator's hand.

Not exactly.  If "nice" is being (automatically) fiddled to meet some 
measurable requirement such as the amount of CPU tasks get it is no 
longer available as a means for the indication of the relative 
importance of the tasks.  I.e. it can't be both the means for saying 
which tasks should be allocated the most CPU and the means by which that 
allocation is controlled.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
