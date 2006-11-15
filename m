Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161741AbWKOVkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161741AbWKOVkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161743AbWKOVkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:40:40 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:58387 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1161741AbWKOVkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:40:39 -0500
Message-ID: <455B8979.6090101@cfl.rr.com>
Date: Wed, 15 Nov 2006 16:41:13 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Yakov Lerner <iler.ml@gmail.com>
CC: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: locking sectors of raw disk (raw read-write test of mounted disk)
References: <f36b08ee0611151206k50284ef9n43d7edf744ae2f19@mail.gmail.com>
In-Reply-To: <f36b08ee0611151206k50284ef9n43d7edf744ae2f19@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2006 21:41:16.0236 (UTC) FILETIME=[C755E8C0:01C708FE]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14816.000
X-TM-AS-Result: No--8.475200-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, you can not tamper with the underlying data while the kernel has it 
mounted.

Yakov Lerner wrote:
> I'd like to make read-write test of the raw disk, and disk has
> mounted partitions. Is it possible to lock  range of sectors
> of the raw device so that any kernel code that wants to write
> to this range will sleep ? (so that test
>    { lock range; read /dev/hda->buf; write buf->/dev/hda; unlock }
> won't corrupt the filesysyem ?)
> 
> Thanks
> Yakov

