Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTGIC6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 22:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbTGIC6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 22:58:03 -0400
Received: from mithril.c-zone.net ([63.172.74.235]:63250 "EHLO mail.c-zone.net")
	by vger.kernel.org with ESMTP id S265591AbTGIC6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 22:58:01 -0400
Message-ID: <3F0B8844.9070108@c-zone.net>
Date: Tue, 08 Jul 2003 20:13:08 -0700
From: jiho@c-zone.net
Organization: Kidding of Course
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zygo Blaxell <uixjjji1@umail.furryterror.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 IDE and IEEE1394+SBP2 regressions, orinoco_pci progress
References: <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Zygo Blaxell wrote:

> Previously on kernels up to 2.4.20, an IDE disk I/O request that was in
> progress at suspend time would trigger a DMA reset upon resume, after a
> short delay while waiting for the timeout.  2.4.20 looked like this:
> 
>         ide_dmaproc: chipset supported ide_dma_lostirq func only: 13 hda:
>         lost interrupt
> 
> After this, the machine happily resumes whatever it was doing.  There is a
> delay of a few seconds while this happens.

Excuse my ignorance -- I suppose I'm blundering around here with a 
number of IDE issues -- but what do you mean by, "at suspend time"?

How can there be a "suspend time" while a disk I/O request is "in progress"?


-- Jim Howard  <jiho@c-zone.net>

