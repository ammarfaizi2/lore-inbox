Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUK2MgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUK2MgY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbUK2MfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:35:17 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:53181 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261701AbUK2Mc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:32:59 -0500
Date: Mon, 29 Nov 2004 21:34:31 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: Re: [lkdump-develop] Re: [ANNOUNCE 0/7] Diskdump 1.0 Release
In-reply-to: <1101727191.2814.52.camel@laptop.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, lkdump-develop@lists.sourceforge.net
Message-id: <42C4D60FC636FDindou.takao@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.71
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
References: <1101727191.2814.52.camel@laptop.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004 12:19:52 +0100, Arjan van de Ven wrote:

>On Mon, 2004-11-29 at 19:35 +0900, Takao Indoh wrote:
>> Hi, all!
>> I release diskdump 1.0 for kernel 2.6.9. It can be downloaded from
>> the following site. Please feel free to use it!
>>    http://sourceforge.net/projects/lkdump
>> 
>> Diskdump project is a joint development of RedHat and Fujitsu, and I'd 
>
>I think the company name is spelled Red Hat ;)

Sorry.


>> like to express my gratitude to a RedHat developers for many comments
>> and advices.
>
>Can you explain to me why anyone would want to use this invasive patch 
>(it requires all drivers to change) instead of the kexec-dump approach? The
>kexec-dump approach appears on first sight to be far cleaner and far more 
>powerful,
>so there must be a reason this work was done regardless of that.. I'm 
>curious 
>what those reasons are, eg what's the advantage ???

The problem of kexec-dump is that initialization of devices depends
on the quality of device driver when kexec reboots system. Sometimes the
device drivers tacitly rely on the firmware to initialize them.

Anyway, most important point is that kexec-dump is not available enough
now. I think kexec-dump is not stable yet. I heard that kexec-dump of
some architecture (ex. ia64) had some problems and not worked.

Best Regards,
Takao Indoh
