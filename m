Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTLBU4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTLBU4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:56:18 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:13725 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264379AbTLBU4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:56:15 -0500
Subject: Re: PROBLEM: 2.6.0-test11 missing acpi-performance interface
	on	centrino
From: Christophe Saout <christophe@saout.de>
To: Robert Freund <robert.freund@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5332.1070389142@www60.gmx.net>
References: <1070384429.21490.4.camel@leto.cs.pocnet.net>
	 <5332.1070389142@www60.gmx.net>
Content-Type: text/plain
Message-Id: <1070398575.10571.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Dec 2003 21:56:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 02.12.2003 schrieb Robert Freund um 19:19:

> > > [1.] One line summary of the problem:
> > > In 2.6.0-test11 the acpi/performance interface is missing on centrino.
> > 
> > I would say this is simply because ACPI is not used within the centrino
> > cpufreq interface driver. You should use the sysfs interface anyway.
> 
> The latter is certainly right... but since there is a kernel config option
> that lets you add the /proc/acpi/.../performance interface explicitly and it
> doesn't work, I consider it a bug. 

This is only a suboption to the acpi cpufreq driver.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

