Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUI2MoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUI2MoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUI2MoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:44:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:46237 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268342AbUI2MoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:44:07 -0400
Subject: Re: [Patch]: fix cpufrequency scaling on ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: Benjamin Herrenschmidt <benh.kernel.crashing.org@bogon.ms20.nix>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040928124057.GA3871@bogon.ms20.nix>
References: <20040928124057.GA3871@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1096461674.22092.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 22:41:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-28 at 22:40, Guido Guenther wrote:
> Hi,
> attached patch against 2.6.9-rc2 fixes cpufrequency scaling after resume
> on pmacs. Please apply.

It's actually still not clear wether we resume at the same speed we
had when going to sleep .. especially in the PMU cpufreq case...

I didn't have time to experiment with this yet tho.

Ben.


