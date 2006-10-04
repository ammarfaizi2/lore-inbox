Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWJDVwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWJDVwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWJDVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:52:35 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:62615 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1751175AbWJDVwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:52:34 -0400
Date: Wed, 4 Oct 2006 23:53:53 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       Borislav Deianov <borislav@users.sourceforge.net>
Subject: T60 ACPI events on 78b656b8
Message-ID: <20061004215352.GG9723@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060830144646.GC1923@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830144646.GC1923@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just tested the latest Linux git, and I see a weird issue:
after some use, my T60 stops triggering any ACPI events:
tail -f /var/log/acpid
does not show anything, even on Fn/F4 which is supposed ot be always enabled.
Restarting the acpid doesn't do anything either - ACPI starts working
again, for a while, only after reboot.

This worked fine in 2.6.18 - any ideas? How to debug this?

-- 
MST
