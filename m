Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUIHM5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUIHM5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUIHM4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:56:15 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:22498 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267555AbUIHMv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:51:29 -0400
Date: Wed, 8 Sep 2004 08:55:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: Fw: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
In-Reply-To: <200409081419.15606.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.53.0409080855390.15087@montezuma.fsmlabs.com>
References: <20040908021637.57525d43.akpm@osdl.org>
 <20040908102652.GA2921@atrey.karlin.mff.cuni.cz> <200409081419.15606.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Rafael J. Wysocki wrote:

> Eeek.  I can't disable the NMI watchdog on x86-64, can I?  According to 
> Documentation/nmi_watchdog.txt:
> 
> "For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
> always enabled with I/O-APIC mode (nmi_watchdog=1)."

Try nmi_watchdog=0

	Zwane

