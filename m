Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUIVWaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUIVWaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUIVWaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:30:46 -0400
Received: from hera.kernel.org ([63.209.29.2]:42684 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S268060AbUIVWae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:30:34 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: /sys: Network device status: link; Hard disks?
Date: Wed, 22 Sep 2004 15:30:28 -0700
Organization: Open Source Development Lab
Message-ID: <20040922153028.11a85771@dell_ss3.pdx.osdl.net>
References: <20040922141630.GE694@schottelius.org>
	<Pine.LNX.4.61.0409221616561.14486@jjulnx.backbone.dif.dk>
	<20040922222545.GA1442@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1095892229 5684 172.20.1.60 (22 Sep 2004 22:30:29 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 22 Sep 2004 22:30:29 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You probably just want to expose the state of netif_carrier_ok (and netif_running).
Doing it in net-sysfs.c is trivial.  I was hoping someone else would learn something
and do it for me.
