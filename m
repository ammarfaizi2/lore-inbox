Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVF2Hhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVF2Hhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVF2Hhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:37:34 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:61158 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S262467AbVF2Hcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:32:51 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Wed, 29 Jun 2005 00:32:38 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Fwd: [Bug 4774] e1000 driver works on UP, but not SMP x86_64
In-Reply-To: <D53BF43BC70DD511A22500508BB3C0071AA66A3A@wlvexc00.diginsite.com>
Message-ID: <Pine.LNX.4.62.0506290029040.25310@qynat.qvtvafvgr.pbz>
References: <200506252222.18681.adobriyan@gmail.com>
 <D53BF43BC70DD511A22500508BB3C0071AA66A3A@wlvexc00.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just to make things more interesting, I have this card working on a dual 
athlon system (with the attached config) on 2.6.7

David Lang

On Sun, 26 Jun 2005, David Lang wrote:

> Date: Sun, 26 Jun 2005 17:52:23 -0700 (PDT)
> From: David Lang <dlang@digitalinsight.com>
> To: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
> Subject: Re: Fwd: [Bug 4774] e1000 driver works on UP, but not SMP x86_64
> 
> On Sat, 25 Jun 2005, Alexey Dobriyan wrote:
>
>> ------- Additional Comments From nacc@us.ibm.com  2005-06-25 10:55 -------
>> Hrm, that means that the corresponding PCI device (adapter->pdev->irq) is
>> requesting an IRQ greater than 224? Could you also attach the SMP .config? 
>> I
>> assume all you did was enabled SMP, ran make oldconfig & rebuilt? Do you 
>> know of
>> any kernel that *does* work?
>
>
> I have a dual athlon system which I have used with one of these cards without 
> a problem, monday I'll try pulling some of the cards out of a machine and see 
> if that eliminates the error.
>
> I had the SMP config, tested it, then disables SMP and recompiled to generate 
> the .config I sent earlier
>
> attached is the config I used with the debug test
>
> David Lang
>
> -- 
> There are two ways of constructing a software design. One way is to make it 
> so simple that there are obviously no deficiencies. And the other way is to 
> make it so complicated that there are no obvious deficiencies.
> -- C.A.R. Hoare
>
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
