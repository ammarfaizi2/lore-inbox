Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTKAWrS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 17:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTKAWrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 17:47:18 -0500
Received: from 015.atlasinternet.net ([212.9.93.15]:25311 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S261193AbTKAWrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 17:47:17 -0500
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Peter Osterlund <petero2@telia.com>
Subject: Re: Synaptics losing sync
Date: Sat, 1 Nov 2003 23:47:14 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200311011751.39610.gallir@uib.es> <m2k76jssvx.fsf@p4.localdomain>
In-Reply-To: <m2k76jssvx.fsf@p4.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311012347.14642.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 November 2003 22:04, Peter Osterlund shaped the electrons 
to shout:
> > The laptop is a Dell X200 with APM and cpufreq enabled, and IO-apic
> > disabled.
> >
> > I tested with and w/o preemptive kernel and cpufreq with the same
> > results.
>
> Did you try without APM? My laptop loses many clock ticks if I enable
> APM. It works fine with ACPI though.

It seems this is the problem, running with acpi during half an hour 
without any error. The synaptics mouse feels much "smoother" too.

But ACPI doesn't see the battery nor the power button in my laptop though. 

Thanks, after months trying the new synaptics driver, fianlly you pointed 
out the problem.

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

