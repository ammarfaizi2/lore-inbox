Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVLaLOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVLaLOG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVLaLOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:14:06 -0500
Received: from isilmar.linta.de ([213.239.214.66]:20695 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932151AbVLaLNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:13:16 -0500
Date: Sat, 31 Dec 2005 12:09:55 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Con Kolivas <kernel@kolivas.org>, len.brown@intel.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org
Subject: [PATCH 0/4] ACPI C-States policy update [Was: [PATCH] i386 No Idle HZ aka dynticks 051228]
Message-ID: <20051231110955.GA9123@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Con Kolivas <kernel@kolivas.org>, len.brown@intel.com,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Daniel Petrini <d.pensator@gmail.com>,
	Tony Lindgren <tony@atomide.com>, vatsa@in.ibm.com,
	ck list <ck@vds.kolivas.org>, Pavel Machek <pavel@ucw.cz>,
	Adam Belay <abelay@novell.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, linux-acpi@vger.kernel.org
References: <200512281718.14897.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512281718.14897.kernel@kolivas.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The following four patches improve the ACPI C-States handling. The first
three ones are independent of dynticks.

Len, please take a look at the first three patches, and if you think they're
correct, please merge them.

Con, regarding your dyn-tick patches: please remove the two patches from your
patchset which touch drivers/acpi/processor_idle.c and
include/acpi/processor.h, and replace them with these updated versions.

Thanks!

	Dominik
