Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269604AbUICKy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269604AbUICKy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269610AbUICKy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:54:58 -0400
Received: from aun.it.uu.se ([130.238.12.36]:57762 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269604AbUICKy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:54:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16696.19829.425751.947622@alkaid.it.uu.se>
Date: Fri, 3 Sep 2004 12:54:45 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc input/output-operations
In-Reply-To: <1094206957.413845ed84b54@rmc60-231.urz.tu-dresden.de>
References: <1094206957.413845ed84b54@rmc60-231.urz.tu-dresden.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hendrik Fehr writes:
 > APIC error on CPU0: 00(40)
 > APIC error on CPU0: 40(40)
 > APIC error on CPU0: 40(40)

These are "received illegal vector" errors. They indicate
a serious problem, either with the local APIC bus itself,
or with how the ACPI/MP tables cause us to program the local
and I/O APICs.

Do the errors persist if you disable ACPI?
