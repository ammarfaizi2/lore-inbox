Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264695AbUFDAna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbUFDAna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 20:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUFDAna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 20:43:30 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:65494 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264695AbUFDAn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 20:43:29 -0400
Date: Fri, 04 Jun 2004 09:44:44 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH]Diskdump - yet another crash dump function
In-reply-to: <20040603131007.GB3915@openzaurus.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <4BC449CD20D638indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040603131007.GB3915@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

On Thu, 03 Jun 2004 15:10:07 +0200, Pavel Machek wrote:

>> Although I know about LKCD and netdump, I'm developing yet another crash
>> dump, which is a polling-based disk dump as netdump do. Because it
>> disables any interrupts during doing dump, it can avoid lots of problems
>> LKCD has.
>> 
>> Main Feature
>> - Reliability
>>    Diskdump disables interrupts, stops other cpus and writes to the 
>>    disk with polling mode. Therefore, unnecessary functions(like
>>    interrupt handler) don't disturb dumping.
>
>Hmm... with this, better design of swsusp mifht be feasible.

I don't know mechanism of swsusp well.
Do you mean diskdump is useful when saving system memory to the disk?

Regards,
Takao Indoh
