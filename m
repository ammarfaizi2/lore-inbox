Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUD1Tip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUD1Tip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUD1TiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:38:24 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:11255 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S264956AbUD1QvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:51:06 -0400
Date: Wed, 28 Apr 2004 12:50:43 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP kernel network problem
In-Reply-To: <1118873EE1755348B4812EA29C55A9721D6D54@esnmail.esntechnologies.co.in>
Message-ID: <Pine.LNX.4.58.0404281249250.3414@montezuma.fsmlabs.com>
References: <1118873EE1755348B4812EA29C55A9721D6D54@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Srinivas G. wrote:

> Hi,
>
> We are using P4 HT Processor, RealTech 8139 Network card, Redhat 9.0
> Kernel version 2.4.20-8smp.
>
> When the system is booting form uni processor mode, I am able to ping
> other systems in the network. But when I boot in SMP mode I am not able
> to ping remote systems and am able to self ping. What may be the
> problem? Is there any hardware problem? Is there any OS problem?
>
> If any body knows about it please let me know.
>
> Thanks and regards,

Since you're using HT i take it you have ACPI enabled? If so try also
booting with the following kernel parameter;

pci=noacpi
