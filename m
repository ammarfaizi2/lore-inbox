Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbUKAMGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUKAMGv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbUKAMGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:06:51 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48308 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261761AbUKAMGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:06:37 -0500
Date: Mon, 1 Nov 2004 13:06:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christoph Hellwig <hch@infradead.org>
cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Disambiguation for panic_timeout's sysctl
In-Reply-To: <20041101120411.GA26958@infradead.org>
Message-ID: <Pine.LNX.4.53.0411011306050.8352@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0410311721470.20529@yvahk01.tjqt.qr>
 <20041101120227.GA24626@suse.de> <20041101120411.GA26958@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > The /proc/sys/kernel/panic file looked to me like it was something like
>> > /proc/sysrq-trigger -- until I looked into the kernel sources which reveal that
>> > it sets the variable "panic_timeout" in kernel/sched.c.
>>
>> This will probably break applications that expect the filename 'panic'.
>
>And why should applications care for the panic timeout?  Especially only
>a few days after it's been added to the kernel?

So it's a brand new variable in sysctl after all? Well then I'd like the change
even more :)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
