Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVLaALM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVLaALM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVLaALM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:11:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:31618 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964974AbVLaALM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:11:12 -0500
Date: Sat, 31 Dec 2005 01:10:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dianogsing a hard lockup
In-Reply-To: <43A451C8.9090304@shaw.ca>
Message-ID: <Pine.LNX.4.61.0512310038240.32485@yvahk01.tjqt.qr>
References: <5kMWZ-2PF-7@gated-at.bofh.it> <43A451C8.9090304@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Try nmi_watchdog=1 on the kernel command line. That may get you a stack trace
> for the lockup.

That does not seem to work.
APIC is enabled, but the kernel reports "No local APIC present or hardware 
disabled". /proc/interrupts only lists XT PICs, and the NMI counter in 
interrupts is also 0.


Jan Engelhardt
-- 
