Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWKBPfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWKBPfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWKBPfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:35:20 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:19903 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750842AbWKBPfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:35:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Lockup with cpufreq that may be similar to recently fixed acpi_cpufreq
Date: Thu, 2 Nov 2006 16:33:30 +0100
User-Agent: KMail/1.9.1
Cc: "Trever L. Adams" <tadams-lists@myrealbox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1162037001.2465.14.camel@aurora.localdomain> <20061102123357.GA4826@ucw.cz>
In-Reply-To: <20061102123357.GA4826@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021633.30893.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 2 November 2006 13:33, Pavel Machek wrote:
> Hi!
> 
> > This may be a single vendor problem. I am having a difficult time
> > getting the vendor to respond. However, I have a dual core Turion laptop
> > which is locking up on resume from suspend (resume from hibernate now
> > works fine). Below is the DWARF2 trace back. It is showing a problem in
> > cpufreq_resume (if I read this correctly). I think this may be similar
> > to a problem that was recently fixed, that had the same symptoms, in
> > acpi_cpufreq. This is 2.6.18.
> 
> Try rmmod cpufreq to see if it is cpufreq problem or if something else
> causes the lockup.

I assume "hibernate" means "suspend to disk".  If that is correct, it may be
a BIOS or ACPI problem that manifests itself this way.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
