Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266436AbUHBKHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUHBKHr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUHBKHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:07:46 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:5136
	"EHLO muru.com") by vger.kernel.org with ESMTP id S266436AbUHBKHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:07:42 -0400
Date: Mon, 2 Aug 2004 03:07:01 -0700
From: Tony Lindgren <tony@atomide.com>
To: Randall Nortman <linuxkernellist@wonderclown.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MSI K8N Neo + powernow-k8: ACPI info is worse than BIOS PST
Message-ID: <20040802100658.GC10412@atomide.com>
References: <20040731140008.GJ4108@li2-47.members.linode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731140008.GJ4108@li2-47.members.linode.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Randall Nortman <linuxkernellist@wonderclown.com> [040731 07:01]:
> 
> If anybody qualified to hack this code is interested in creating a
> real workaround for BIOSes like this, I offer my system (and my time,
> as I cannot give remote access) for testing.  I would suggest adding a
> compile-time or load-time option to prefer the BIOS over ACPI (as in
> powernow-k7, I think), and maybe a compile-time option to use Tony's
> hardcoded tables.

Just to clarify a bit, my patch only uses the 800MHz hardcoded, which
should work on all AMD64 processors. The max value used is the current
running value.

Tony
