Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWJKWwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWJKWwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJKWwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:52:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:11046 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1161187AbWJKWwv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:52:51 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,295,1157353200"; 
   d="scan'208"; a="144948412:sNHT3134607154"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] IA64 export symbols empty_zero_page, ia64_ssc
Date: Wed, 11 Oct 2006 15:52:28 -0700
Message-ID: <617E1C2C70743745A92448908E030B2AA634B8@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] IA64 export symbols empty_zero_page, ia64_ssc
Thread-Index: Acbr7+VTBH9yuHiSQdCODq93GfL8QgBlnCMw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Judith Lebzelter" <judith@osdl.org>
Cc: <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2006 22:52:29.0292 (UTC) FILETIME=[EDD142C0:01C6ED87]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Judith,

+++ linux/arch/ia64/kernel/ia64_ksyms.c	2006-10-09 10:15:18.000000000 -0700

These exports are only needed for the HP simulator ... it seems
probable that the more likely fix is change Kconfig to prevent simscsi
from being built as a module.  I assume that any remaining SKI users
build this into the kernel ... arch/ia64/configs/sim_defconfig sets
CONFIG_HP_SIMSCSI=y for example.

-Tony
