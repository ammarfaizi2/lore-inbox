Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWI1UcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWI1UcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWI1UcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:32:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:37511 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750726AbWI1UcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:32:05 -0400
Message-ID: <451C3140.4090201@pobox.com>
Date: Thu, 28 Sep 2006 16:32:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       linux-ide@vger.intel.com, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: [patch 1/2] libata: _GTF support
References: <20060928182211.076258000@localhost.localdomain>	<20060928112901.62ee8eba.kristen.c.accardi@intel.com> <20060928205144.98aefd13.diegocg@gmail.com>
In-Reply-To: <20060928205144.98aefd13.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> El Thu, 28 Sep 2006 11:29:01 -0700,
> Kristen Carlson Accardi <kristen.c.accardi@intel.com> escribió:
> 
>> +config SATA_ACPI
>> +	bool
>> +	depends on ACPI && PCI
> 
> Why not s/SATA_ACPI/ACPI/ and delete the kconfig option, so this
> feature gets enabled automatically when user enables ACPI?

It's a reasonable request, but I think it's better to integrate as-is, 
and then delete the Kconfig option as you describe once everybody is 
happy with the upstream, [hopefully-]working code.

	Jeff



