Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbUABLcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 06:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUABLcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 06:32:22 -0500
Received: from hell.org.pl ([212.244.218.42]:5391 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S265511AbUABLcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 06:32:20 -0500
Date: Fri, 2 Jan 2004 12:32:21 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Martin Loschwitz <madkiss@madkiss.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI and framebuffer related problems with Linux 2.6.1-rc1
Message-ID: <20040102113221.GA13322@hell.org.pl>
Mail-Followup-To: "Yu, Luming" <luming.yu@intel.com>,
	Martin Loschwitz <madkiss@madkiss.org>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <3ACA40606221794F80A5670F0AF15F8401720C6E@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C6E@PDSMSX403.ccr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Yu, Luming:
> >However, there is a problem with ACPI:
> /proc/acpi/processor/CPU0/performance, 
> >which was there in previous versions of the kernel and allowed me to
> slow the 
> >CPU down in order to save power, disappeared in Linux 2.6.1-rc1. It's
> simply 
> >not there anymore. Was it replaced? 
> 
> It sounds like a regression. Would you file it on
> http://bugzilla.kernel.org

I guess he needs rather to compile the ACPI performance CPUFreq driver and
insmod acpi.ko, or something similar. That's a pretty non-obvious change
over 2.4.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
