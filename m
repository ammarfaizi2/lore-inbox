Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTEMLQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 07:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTEMLQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 07:16:04 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:3490 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263571AbTEMLQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 07:16:03 -0400
Subject: 2.5: acpi_power_off doesn't turn machine off
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1052825263.605.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 13:27:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.5.69-mm4 (and previous versions too) is unable to properly shut down
the machine when using ACPI. Instead, it invokes acpi_power_off and then
hangs, needed me to manually cycle the power.

Is this a kernel-related problem, or should I bug further details to the
ACPI mailing list?

Thanks!

