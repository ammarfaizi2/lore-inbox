Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUHDKvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUHDKvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 06:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUHDKvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 06:51:18 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:17514 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263429AbUHDKvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 06:51:17 -0400
Message-ID: <4110BE9B.3040701@yahoo.com.au>
Date: Wed, 04 Aug 2004 20:46:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au> <20040804103143.GA13072@elte.hu>
In-Reply-To: <20040804103143.GA13072@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Also, basic interactivity in X is bad with the interactive sysctl set
>>to 0 (is X supposed to be at nice 0?), however fairness is bad when
>>interactive is 1. I'm not sure if this is an acceptable tradeoff - are
>>you planning to fix it?
> 
> 
> it also has clear interactivity problems when just running lots of CPU
> hogs even with the default interactive=1 compute=0 setting.
> 
> 
>>Increasing priority (negative nice) doesn't have much impact. -20 CPU
>>hog only gets about double the CPU of a 0 priority CPU hog and only
>>about 120% the CPU time of a nice -10 hog.
> 
> 
> this is a property of the base scheduler as well.
> 

*blush*. Well I shouldn't have singled out the staircase scheduler
with this then.

I think I would prefer your nonlinear ratios better though.
