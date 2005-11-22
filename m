Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVKVGdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVKVGdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 01:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVKVGdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 01:33:23 -0500
Received: from fsmlabs.com ([168.103.115.128]:33717 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932087AbVKVGdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 01:33:23 -0500
X-ASG-Debug-ID: 1132641200-12763-52-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Mon, 21 Nov 2005 22:39:02 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: 2.6.14.2 detects only one processor (out of 2)
Subject: Re: 2.6.14.2 detects only one processor (out of 2)
In-Reply-To: <43826414.4060701@shaw.ca>
Message-ID: <Pine.LNX.4.61.0511212236440.20538@montezuma.fsmlabs.com>
References: <5bpni-8r0-5@gated-at.bofh.it> <5bsEh-4Sc-51@gated-at.bofh.it>
 <43826414.4060701@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5470
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Robert Hancock wrote:

> Philippe Pegon wrote:
> > Hi,
> > 
> > try with acpi enabled, it works for me. It's seem that recent kernel (since
> > 2.6.12) need acpi for SMP.
> 
> It should not - if it does this is a bug, as SMP motherboards that do not
> support ACPI will not work.

Looks like we got rid of CONFIG_ACPI_BOOT, his particular system has an 
incomplete mptable and requires ACPI for proper processor enumeration.
