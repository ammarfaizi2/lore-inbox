Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbULABAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbULABAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbULAA7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:59:44 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:30423 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261170AbULAAsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:48:35 -0500
Date: Wed, 01 Dec 2004 09:50:02 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [ANNOUNCE 1/7] Diskdump 1.0 Release
In-reply-to: <1101785039.14565.11.camel@localhost.localdomain>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkdump-develop@lists.sourceforge.net
Message-id: <44C4D73FB0E4B3indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.71
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <1101785039.14565.11.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004 14:23:59 +1100, Rusty Russell wrote:

>On Mon, 2004-11-29 at 19:37 +0900, Takao Indoh wrote:
>> This is a patch for diskdump common layer.
>...
>
>> +static int fallback_on_err = 1;
>> +static int allow_risky_dumps = 1;
>> +static unsigned int block_order = 2;
>> +static int sample_rate = 8;
>> +module_param_named(fallback_on_err, fallback_on_err, bool, S_IRUGO|
>> S_IWUSR);
>> +module_param_named(allow_risky_dumps, allow_risky_dumps, bool, S_IRUGO|
>> S_IWUSR);
>> +module_param_named(block_order, block_order, uint, S_IRUGO|S_IWUSR);
>> +module_param_named(sample_rate, sample_rate, int, S_IRUGO|S_IWUSR);
>
>You can just use "module_param" here (and elsewhere in the patch), since
>the name is the same as the variable name.

I see, thanks!


Best Regards,
Takao Indoh
