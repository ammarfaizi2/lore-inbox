Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVAaO3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVAaO3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVAaO3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:29:33 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:62902 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261220AbVAaO2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:28:39 -0500
Message-ID: <41FE4096.6030103@suse.de>
Date: Mon, 31 Jan 2005 15:28:38 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>,
       mjg59@srcf.ucam.org
Subject: Re: [PATCH] Resume from initramfs
References: <41FE24F5.5070906@suse.de> <20050131125110.GD6279@elf.ucw.cz>	<41FE3C34.4000200@suse.de> <jehdkxhdz7.fsf@sykes.suse.de>
In-Reply-To: <jehdkxhdz7.fsf@sykes.suse.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> Hannes Reinecke <hare@suse.de> writes:
> 
> 
>>--- linux-2.6.10/kernel/power/disk.c.orig	2005-01-31
>>    13:54:17.000000000 +0100
>>+++ linux-2.6.10/kernel/power/disk.c	2005-01-31 14:55:14.000000000 +0100
>>@@ -9,6 +9,8 @@
>>   *
>>   */
>>
>>+#define DEBUG
>>+
>>  #include <linux/suspend.h>
>>  #include <linux/syscalls.h>
>>  #include <linux/reboot.h>
>>--- linux-2.6.10/kernel/power/swsusp.c.orig	2005-01-31
>>    13:54:17.000000000 +0100
>>+++ linux-2.6.10/kernel/power/swsusp.c	2005-01-31 14:53:36.000000000 +0100
>>@@ -36,6 +36,8 @@
>>   * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
>>   */
>>
>>+#define DEBUG
>>+
>>  #include <linux/module.h>
>>  #include <linux/mm.h>
>>  #include <linux/suspend.h>
> 
> 
> Another leftovers?
> 
> Andreas.
> 
Yes. I'll clean that up once someone (ie Pavel) gives his thumbs-up.

Doesn't do any harm, really. swsusp in itself is chatty enough, two 
additional lines don't really matter.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
