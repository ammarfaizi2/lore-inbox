Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVEDJva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVEDJva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 05:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVEDJva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 05:51:30 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:47313 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261574AbVEDJv2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 05:51:28 -0400
Date: Wed, 4 May 2005 11:44:47 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] ds1337 2/3
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <E1tkFUIb.1115199887.7528640.khali@localhost>
In-Reply-To: <20050504061354.GC1439@orphique>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "James Chapman" <jchapman@katalix.com>, "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ladislav, hi all,

> i2c_transfer returns number of sucessfully transfered messages. Change
> error checking to accordingly. (ds1337_set_datetime never returned
> sucess)

I think you mean ds1337_GET_datetime, not ds1337_SET_datetime, never
returned success?

Anyway I like the patch, it makes the driver treat the value returned by
i2c_transfer() properly and makes the code overall more consistent.

Thanks,
--
Jean Delvare
