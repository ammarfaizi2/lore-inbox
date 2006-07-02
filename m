Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWGBLYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWGBLYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 07:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGBLYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 07:24:40 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:19717 "EHLO
	smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP id S964840AbWGBLYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 07:24:39 -0400
Message-ID: <44A7ACF2.4070304@xs4all.nl>
Date: Sun, 02 Jul 2006 13:24:34 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Oops / BUG? (2.6.17.2 on VIA Epia CL6000)
References: <44A7AADB.8040106@xs4all.nl> <1151839268.3111.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1151839268.3111.10.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2006-07-02 at 13:15 +0200, Udo van den Heuvel wrote:
>> Hello,
>>
>> On my otherwise stable Via EPIA CL6000 I experienced an OOPS.
>> Hardware should be OK. I was unable to reproduce the event, so far.
>> In what part of the kernel did things go wrong?
>> What can I do to help fix the bug? (if it is indeed a bug)
> 
> Hi,
> 
> something really bad happened (the processor jumped into hyperspace);
> however it looks like automatic symbol resolving isn't working;
> could you check if CONFIG_KALLSYMS is enabled in your kernel config?
> With that enabled, debugability tends to go up bigtime since at least
> the backtrace becomes human readable...

I have:

CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set


Kind regards,
Udo
