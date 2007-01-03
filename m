Return-Path: <linux-kernel-owner+w=401wt.eu-S1754071AbXACDl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbXACDl5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 22:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbXACDl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 22:41:57 -0500
Received: from hera.kernel.org ([140.211.167.34]:58389 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923AbXACDlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 22:41:55 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: ACPI: EC: evaluating _Q10
Date: Tue, 2 Jan 2007 22:41:05 -0500
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <45992109.9050009@m3y3r.de> <200701021205.07817.lenb@kernel.org> <459AC146.9020804@m3y3r.de>
In-Reply-To: <459AC146.9020804@m3y3r.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701022241.05303.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The bigger question is why you get "tons of these" --
> > as EC  events are usually infrequent.
> > Do you have a big number next to "acpi" in /proc/interrupts?
> > If so, at what rate is it growing?
> 
> maybe tons were a bit to overstated... After a fresh reboot, i count 110 
> _q10 and one _q21messages now with 8 min. uptime and around 10300 acpi 
> interrupts.

480 sec/110 ec events = 4 seconds/event.  This doesn't worry me.
Could be battery updates, thermal updates etc.

480/10300 = an interrupt every 46 ms.
This is certainly not right.
Have you always seen runaway acpi interrupts on this box, no matter the kernel?

thanks,
-Len

