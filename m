Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWB1MOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWB1MOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWB1MOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:14:14 -0500
Received: from mail.dvmed.net ([216.237.124.58]:28037 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932517AbWB1MOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:14:12 -0500
Message-ID: <44043E90.8060602@pobox.com>
Date: Tue, 28 Feb 2006 07:14:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 10/13] ATA ACPI: do taskfile before mode commands
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222140140.0d9e41b7.randy_d_dunlap@linux.intel.com> <20060228115715.GE4081@elf.ucw.cz> <44043C7D.5090207@pobox.com> <20060228120843.GC3695@elf.ucw.cz>
In-Reply-To: <20060228120843.GC3695@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Please, just remove them. Driver model core already has debugging that
> can be enabled and prints what is called.
> 
> I do not think we want printk() at begining of every *_resume
> function.

They will not be removed, but instead limited by a bit test as I stated.

	Jeff


