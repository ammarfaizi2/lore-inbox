Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWIJOPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWIJOPh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 10:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWIJOPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 10:15:37 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:59015 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932172AbWIJOPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 10:15:36 -0400
Date: Sun, 10 Sep 2006 15:15:34 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: io-apic breaks suspend unless acpi_skip_timer_override
Message-ID: <20060910141533.GA6594@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI suspend/resume fails on my HP nx6125 unless I either:

a) boot with noapic, or
b) boot with acpi_skip_timer_override

Does anyone have the faintest idea how to debug this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
