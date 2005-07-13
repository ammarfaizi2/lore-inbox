Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVGMIAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVGMIAI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 04:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVGMIAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 04:00:08 -0400
Received: from boss.staszic.waw.pl ([195.205.163.66]:32409 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP id S262629AbVGMIAF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 04:00:05 -0400
Date: Wed, 13 Jul 2005 10:00:03 +0200 (CEST)
From: Tomasz Lemiech <szpajder@staszic.waw.pl>
To: Chris Wright <chrisw@osdl.org>
cc: torvalds@osdl.org, len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.2 acpi_register_gsi() patch causes problems on Asus A7V333
 motherboard
In-Reply-To: <20050712201519.GB19052@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.63.0507130957490.2949@boss.staszic.waw.pl>
References: <Pine.LNX.4.63.0507121940170.11987@boss.staszic.waw.pl>
 <20050712182007.GX19052@shell0.pdx.osdl.net> <Pine.LNX.4.63.0507122153110.24219@boss.staszic.waw.pl>
 <20050712201519.GB19052@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Chris Wright wrote:

> * Tomasz Lemiech (szpajder@staszic.waw.pl) wrote:
>> On Tue, 12 Jul 2005, Chris Wright wrote:
>>
>>>> - 2.6.12.2 with acpi_register_gsi() one-line fix works without problems
>>
>> My apologies - I meant: "_without_ acpi_register_gsi() one-line fix". That
>> is, _reverting_
>> http://www.kernel.org/git/?p=linux/kernel/git/gregkh/linux-2.6.12.y.git;a=commit;h=1ef0867a529b222b8ff659d68140df8d5d6a45f2
>> from 2.6.12.2 fixes the problem.
>
> Can you verify that the patch below (w/out reverting that patch, apply
> on top of) fixes it for you?

Yup, it does, thanks much. Now I see that there was an earlier thread 
concerning the same problem. Sorry for extra noise.

Regards,

-- 
 			     	 Tomasz Lemiech (RLU#189399) (TL4681-RIPE)
 				  <szpajder@staszic.waw.pl> [GG:3786250]
