Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWB1L5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWB1L5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbWB1L5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:57:40 -0500
Received: from mail.dvmed.net ([216.237.124.58]:56963 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751651AbWB1L5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:57:39 -0500
Message-ID: <44043AAD.5050404@pobox.com>
Date: Tue, 28 Feb 2006 06:57:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 4/13] ATA ACPI: add params/docs.
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135403.55086107.randy_d_dunlap@linux.intel.com> <20060228114647.GA4081@elf.ucw.cz>
In-Reply-To: <20060228114647.GA4081@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
>>
>>Add and use 'noacpi' parameter for libata-acpi.
> 
> 
> Why is this option needed? Either the code works, or it does not. If
> it does not, it is not suitable for merging...

Invalid logic.  It is needed for the same reasons that acpi=off is 
supported in the generic ACPI code.

	Jeff



