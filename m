Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTLBRAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTLBRAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:00:31 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:30611 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262327AbTLBRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:00:27 -0500
Subject: Re: PROBLEM: 2.6.0-test11 missing acpi-performance interface on
	centrino
From: Christophe Saout <christophe@saout.de>
To: Robert Freund <bytewise@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <24681.1070381460@www43.gmx.net>
References: <24681.1070381460@www43.gmx.net>
Content-Type: text/plain
Message-Id: <1070384429.21490.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Dec 2003 18:00:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 02.12.2003 schrieb Robert Freund um 17:11:

> [1.] One line summary of the problem:
> In 2.6.0-test11 the acpi/performance interface is missing on centrino.

I would say this is simply because ACPI is not used within the centrino
cpufreq interface driver. You should use the sysfs interface anyway.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

