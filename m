Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUIBT2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUIBT2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 15:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268341AbUIBT2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 15:28:20 -0400
Received: from the-village.bc.nu ([81.2.110.252]:62864 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268234AbUIBT2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 15:28:19 -0400
Subject: Re: [PATCH] ACPI-based i8042 keyboard/aux controller enumeration
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-input@atrey.karlin.mff.cuni.cz,
       Alessandro Rubini <rubini@vision.unipv.it>,
       Len Brown <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200409021152.27472.bjorn.helgaas@hp.com>
References: <200409021152.27472.bjorn.helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094149495.5645.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 19:24:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 18:52, Bjorn Helgaas wrote:
> Add ACPI-based i8042 keyboard and aux controller enumeration.

You should probably also add the same for the non-ACPI path with the
BIOS feature word query stuff in this case ?


