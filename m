Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTIWVEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 17:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbTIWVEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 17:04:22 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:64459
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261334AbTIWVEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 17:04:20 -0400
Subject: RE: NS83820 2.6.0-test5 driver seems unstable on IA64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, bcrl@kvack.org,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064350834.11760.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Tue, 23 Sep 2003 22:00:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-23 at 19:21, Luck, Tony wrote:
> a) the programmer is playing fast and loose with types and/or casts.
> b) the end-user is going to be disappointed with the performance.

c) the programmer is being clever and knows the unaligned access is
cheaper on average than the cost of making sure it cant happen

> Looking at a couple of ia64 build servers here I see zero unaligned
> access messages in the logs.

Anyone who can deliver network traffic to your box can soon fix that...


