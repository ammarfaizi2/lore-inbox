Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUEGLH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUEGLH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 07:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUEGLH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 07:07:59 -0400
Received: from port-213-148-152-119.reverse.qsc.de ([213.148.152.119]:33265
	"EHLO mbs-software.de") by vger.kernel.org with ESMTP
	id S262951AbUEGLH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 07:07:58 -0400
Date: Fri, 7 May 2004 13:07:56 +0200
From: Alex Riesen <fork0@users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: Bob Gill <gillb4@telusplanet.net>, Len Brown <len.brown@intel.com>
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out ...
Message-ID: <20040507110756.GA4647@linux-ari.internal>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083884857.6033.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> zero IDE changes in bk6 -> bk8 but a lot of ACPI / IRQ related

it's bk8 which broke sis961 (or revealed it native brokenness)

> OK.  My APIC is a SiS961.

I have the same problem (and the same chipset).
Passing acpi=noirq helps to work it around.

