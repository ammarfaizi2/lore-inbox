Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWCAMyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWCAMyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWCAMyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:54:25 -0500
Received: from cantor.suse.de ([195.135.220.2]:39138 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750937AbWCAMyY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:54:24 -0500
Message-ID: <4405997E.3040609@suse.de>
Date: Wed, 01 Mar 2006 13:54:22 +0100
From: Hannes Reinecke <hare@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.11) Gecko/20050727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] Enabling of libata PATA support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

does anyone know the status of the libata PATA support?
I know that Alan Cox is intensively working on them, so they should be
in a reasonable state by now.

If that is the case, couldn't we enable PATA support as _optional_
drivers? This would get us ACPI support for those chipset for free (as
SATA ACPI support will be included, yes Jens?). And this is required on
most modern Laptops for suspend to RAM (and possibly also suspend to
disk) to work properly.

Thoughts?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

