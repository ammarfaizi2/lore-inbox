Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTIUWMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 18:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTIUWMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 18:12:09 -0400
Received: from lidskialf.net ([62.3.233.115]:22752 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262591AbTIUWMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 18:12:07 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: JSTHEMASTER <cheaterjs@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.22 ACPI hangs up NFORCE2 system when using kudzu
Date: Sun, 21 Sep 2003 23:12:09 +0100
User-Agent: KMail/1.5.3
References: <3F6E09F7.7000506@gmx.de>
In-Reply-To: <3F6E09F7.7000506@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309212312.09373.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 September 2003 21:28, JSTHEMASTER wrote:
> [1.]
> When using Kernel 2.4.22 (<= 2.4.21 works perfectly) ACPI on a system
> with NFORCE2 chipset the system hangs when starting
> kudzu without any output or log-entry!
>
> [2.]
> If you enable kernel 2.4.22 ACPI on a system running NFORCE2 chipset (I
> got a MSI K7N2 Delta-L mainboard) the system hangs
> when using kudzu (Redhat Hardware detection tool, any version) without
> any output or log entry. I'm sorry, I was unable to monitor any crash
> dump information because the whole system hung up and didn't write any
> data. Kernels 2.4.21 or lower work fine.

Not all nforce2 based motherboards. Most work fine AFAIK.

It sounds like it starts up OK though... I'd need the dmesg from during boot 
with ACPI and APIC enabled to try and diagnose the problem.

