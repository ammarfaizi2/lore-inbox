Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUC1Usk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUC1Uq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:46:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262046AbUC1UpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:45:21 -0500
Message-ID: <40673950.4050703@pobox.com>
Date: Sun, 28 Mar 2004 15:45:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: B.Zolnierkiewicz@elka.pw.edu.pl, axboe@suse.de, wli@holomorphy.com,
       nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com>	<200403282030.11743.bzolnier@elka.pw.edu.pl>	<20040328183010.GQ24370@suse.de>	<200403282045.07246.bzolnier@elka.pw.edu.pl>	<406720A7.1050501@pobox.com> <20040328123240.4332964e.akpm@osdl.org>
In-Reply-To: <20040328123240.4332964e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> I like generic tunables such as "laptop mode" or "low latency" or "high 
>> throughput".  These sorts of tunables should affect the "automagic" 
>> calculations.
> 
> 
> Not sure.  Things like "low latency" and "high throughput" may need other
> things, such as "seek latency" and "bandwidth" as _inputs_, not as outputs.

I should probably better define the hypotheticals :)  I think of "laptop 
mode" or "low latency versus high throughput" more as high level binary 
flags, influencing widely varying things like from an ATA disk's "low 
noise versus high performance" tunable to the IO scheduler's deadlines.


> Such device parameters should have reasonable defaults, and use a userspace
> app which runs a quick seek latency and bandwidth test at mount-time,
> poking the results into sysfs.

Certainly...

	Jeff



