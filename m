Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbTICJ0c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbTICJ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:26:32 -0400
Received: from lidskialf.net ([62.3.233.115]:6278 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261722AbTICJZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:25:29 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Roger Luethi <rl@hellgate.ch>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Where do I send APIC victims?
Date: Wed, 3 Sep 2003 11:23:58 +0100
User-Agent: KMail/1.5.3
Cc: acpi-devel@lists.sourceforge.net
References: <20030903080852.GA27649@k3.hellgate.ch>
In-Reply-To: <20030903080852.GA27649@k3.hellgate.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309031123.58713.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Sep 2003 9:08 am, Roger Luethi wrote:
> As the maintainer of via-rhine, I get bug reports that almost in their
> entirety are "fixed" by turning off APIC and/or ACPI. This has been going
> on for several months now. Every now and then, something promising gets
> posted on LKML, but so far if anything I've seen an _increase_ in those bug
> reports. Maybe a fix is floating around and this will be a non-issue RSN. I
> simply can't tell, since I don't have any IO-APIC hardware to play with.
>
> Instead of just telling everybody to turn off APIC, I'd like to point bug
> reporters to the proper place and tell them what information they should
> provide so it can get fixed for real. According to MAINTAINERS, Ingo Molnar
> does Intel APIC, but the problems are with VIA chip sets. So where do I
> send my users? Any takers?

Hi, I'm trying to develop patches for ACPI IRQ issues. 

Are these VIA KT333/KT400 chipsets? If so, there's a known bug in many BIOSes 
with these chipsets. I'm waiting on some docs from VIA to fix this issue.

