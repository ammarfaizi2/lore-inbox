Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUDMVVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 17:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUDMVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 17:21:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61384 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263760AbUDMVV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 17:21:28 -0400
Message-ID: <407C59CA.8070606@pobox.com>
Date: Tue, 13 Apr 2004 17:21:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A.Magallon" <jamagallon@able.es>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] please test the big post-2.6.5 merge
References: <407C1DD8.5060909@pobox.com> <0FFF7180-8D8F-11D8-BB04-000A9585C204@able.es>
In-Reply-To: <0FFF7180-8D8F-11D8-BB04-000A9585C204@able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A.Magallon wrote:
> 
> On 13 abr 2004, at 19:05, Jeff Garzik wrote:
> 
>>
>> The snapshot 2.6.5-bk1 is out, and has a _ton_ of changes in it that have
> 
> ...
> 
>> * 4K stacks
> 
> 
> Fixed or CONFIG_ ?
> If fixed, this will make unhappy a _ton_ of users...


+config 4KSTACKS
+       bool "Use 4Kb for kernel stacks instead of 8Kb"

