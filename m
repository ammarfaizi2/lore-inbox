Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTLBSTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTLBSTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:19:05 -0500
Received: from pop.gmx.net ([213.165.64.20]:21959 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263082AbTLBSTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:19:03 -0500
Date: Tue, 2 Dec 2003 19:19:02 +0100 (MET)
From: "Robert Freund" <robert.freund@gmx.de>
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <1070384429.21490.4.camel@leto.cs.pocnet.net>
Subject: Re: PROBLEM: 2.6.0-test11 missing acpi-performance interface on	centrino
X-Priority: 3 (Normal)
X-Authenticated: #3960793
Message-ID: <5332.1070389142@www60.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [1.] One line summary of the problem:
> > In 2.6.0-test11 the acpi/performance interface is missing on centrino.
> 
> I would say this is simply because ACPI is not used within the centrino
> cpufreq interface driver. You should use the sysfs interface anyway.

The latter is certainly right... but since there is a kernel config option
that lets you add the /proc/acpi/.../performance interface explicitly and it
doesn't work, I consider it a bug. 

Robert

