Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUCQANX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUCQANX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:13:23 -0500
Received: from hell.org.pl ([212.244.218.42]:28941 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261862AbUCQANW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:13:22 -0500
Date: Wed, 17 Mar 2004 01:13:24 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: john stultz <johnstul@us.ibm.com>
Cc: Dominik Brodowski <linux@brodo.de>, dtor_core@ameritech.net,
       acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Message-ID: <20040317001324.GA19180@hell.org.pl>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	Dominik Brodowski <linux@brodo.de>, dtor_core@ameritech.net,
	acpi-devel@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
References: <20040316182257.GA2734@dreamland.darkstar.lan> <20040316194805.GC20014@picchio.gall.it> <20040316214239.GA28289@hell.org.pl> <1079479694.5408.47.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1079479694.5408.47.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote john stultz:
> Hmm. This is untested, but I think this should do the trick.

Hmm... without the patch, neither cpu MHz nor bogomips are updated, with
the patch cpu MHz value seems correct (both using acpi.ko and
speedstep-ich.ko, but the bogomips is still at its initial value.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
