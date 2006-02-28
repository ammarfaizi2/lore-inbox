Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751720AbWB1L6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWB1L6f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWB1L6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:58:34 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64387 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751693AbWB1L6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:58:34 -0500
Message-ID: <44043AE6.1010407@pobox.com>
Date: Tue, 28 Feb 2006 06:58:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 5/13] ATA ACPI: use debugging macros
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135542.33fe242c.randy_d_dunlap@linux.intel.com> <20060228114733.GB4081@elf.ucw.cz>
In-Reply-To: <20060228114733.GB4081@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On St 22-02-06 13:55:42, Randy Dunlap wrote:
> 
>>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
>>
>>Add more libata-acpi debugging, plus controlled by libata.printk
>>value.
> 
> 
> Please don't. Instead select messages so that it is not too noisy by
> default...

Wrong.  We want fine-grained message selection, just like modern net 
drivers have.  See netif_msg_xxx and friends.

	Jeff



