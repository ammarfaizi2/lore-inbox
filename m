Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVBQPfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVBQPfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVBQPfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:35:46 -0500
Received: from fsmlabs.com ([168.103.115.128]:7612 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262233AbVBQPfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:35:38 -0500
Date: Thu, 17 Feb 2005 08:36:39 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Joseph Cosby <jocosby@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 IO-APIC + timer doesn't work! with VMWare 4
In-Reply-To: <BAY102-F34629FB0CE60DB39785241AE6B0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0502151514230.4128@montezuma.fsmlabs.com>
References: <BAY102-F34629FB0CE60DB39785241AE6B0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005, Joseph Cosby wrote:

> Hi,
>  Using VMWare 4 with a 2.6.9 kernel I get "IO-APIC + timer doesn't work!" As
> suggested, the noapic option fixes the problem. This resulted after adding
> APIC support to my kernel. My problem is, I need APIC support to boot on a
> separate, non-VMWare machine, and I need to keep the kernel and boot params
> the same on both machines.
>  Aside from disabling APIC support, and running with the noapic parameter, can
> anybody suggest how to get this running on the VMware machine?

It works here with 2.6.11-rc3-mm2 and 4.5.2 build 8848

