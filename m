Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWF1TOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWF1TOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWF1TOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:14:31 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:48827 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1750871AbWF1TOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:14:30 -0400
Date: Wed, 28 Jun 2006 21:13:48 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Hamish <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA hangs...
Message-ID: <20060628211348.41df2ef1@localhost>
In-Reply-To: <200606242330.48248.hamish@travellingkiwi.com>
References: <200606232134.42231.hamish@travellingkiwi.com>
	<20060624093659.7bc2a4a0@localhost>
	<20060624100957.73fff572@localhost>
	<200606242330.48248.hamish@travellingkiwi.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006 23:30:43 +0100
Hamish <hamish@travellingkiwi.com> wrote:

> damned stats # gzip -dc /proc/config.gz |grep -i preempt
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_BKL=y
> CONFIG_DEBUG_PREEMPT=y
> damned stats # 
> 
> I also tried 2.6.17-mm but that dies in reiserfs claiming a bug in bitmap.c
> 
> I'll try a re-compile of 2.7.17.1 vanilla with no pre-empt & see how it goes.

It happened again 2 times here, then I've opened the case and done a
"cleanup". I've also switched the power cable of the disk.

After that it isn't happened anymore.

When it happened I think I've heard a small "beep", like a small power
"failure" that made it powering off/on in a fraction of second.
(Is that plausible?)


So maybe mine was an "hardware" problem followed by the software unable
to get the disk to behave correctly... or something.

Another interesting thing is that the disk preserves his state of
brokenness across a reboot... I need a full power OFF/ON to get it back.

I hope to never see this again :)

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
