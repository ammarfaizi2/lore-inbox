Return-Path: <linux-kernel-owner+w=401wt.eu-S1422787AbWLUHP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422787AbWLUHP5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422788AbWLUHP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:15:56 -0500
Received: from main.gmane.org ([80.91.229.2]:42482 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422787AbWLUHP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:15:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Daniel Cheng <gmane@sdiz.net>
Subject: Re: Linux disk performance.
Date: Thu, 21 Dec 2006 15:15:39 +0800
Message-ID: <emdcar$7a0$1@sea.gmane.org>
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>	 <1166431020.3365.931.camel@laptopd505.fenrus.org>	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>	 <4589B92F.2030006@tmr.com> <652016d30612202203h16331f96o2147872db3cb2d43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: n219078109167.netvigator.com
User-Agent: Icedove 1.5.0.8 (X11/20061128)
In-Reply-To: <652016d30612202203h16331f96o2147872db3cb2d43@mail.gmail.com>
Cc: kernelnewbies@nl.linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Regmi wrote:
[...]
>>
>> If you upgrade to a newer kernel you can try other i/o scheduler
>> options, default cfq or even deadline might be helpful.
> 
> I tried all disk schedulers but all had timing bumps. :(
> 

Did you try to disable the on disk write cache?

man hdparm(8)

   -W     Disable/enable the IDE drive´s write-caching
          feature


-- 

