Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTFTSQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbTFTSQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:16:52 -0400
Received: from fmr01.intel.com ([192.55.52.18]:44749 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264037AbTFTSQu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:16:50 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: ACPI source releases updated (20030619)
Date: Fri, 20 Jun 2003 11:30:49 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2FE@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI source releases updated (20030619)
Thread-Index: AcM3WhTvdhavGCuWTJuB2bdN+RX3DQ==
From: "Grover, Andrew" <andrew.grover@intel.com>
To: <acpi-devel@lists.sourceforge.net>
Cc: "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Jun 2003 18:30:49.0829 (UTC) FILETIME=[12C99150:01C3375A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

New Linux 2.4 and 2.5 patches are now available from
http://sf.net/projects/acpi. Big thanks to the asus-acpi team, as well
as all the other people who have been tracking down bugs and submitting
fixes lately.

Regards -- Andy

----------------------------------------
19 June 2003.  Summary of changes for version 20030619:

1) Linux:

acpiphp update (Takayoshi Kochi)

Export acpi_disabled for sonypi (Stelian Pop)

Mention acpismp=force in config help

Re-add acpitable.c and acpismp=force. This improves backwards
compatibility and also cleans up the code to a significant
degree.

Add ASUS Value-add driver (Karol Kozimor and Julien Lerouge)

2) ACPI CA Core Subsystem:

Fix To/FromBCD, eliminating the need for an arch-specific
#define.

Do not acquire a semaphore in the S5 shutdown path.

Fix ex_digits_needed for 0. (Takayoshi Kochi)

Fix sleep/stall code reversal. (Andi Kleen)

Revert a change having to do with control method calling
semantics.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

