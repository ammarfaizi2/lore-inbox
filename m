Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUGESgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUGESgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266363AbUGESgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:36:39 -0400
Received: from fmr01.intel.com ([192.55.52.18]:60044 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266271AbUGESg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:36:27 -0400
Subject: Re: Keyboard/mouse broken under 2.6.[57].
From: Len Brown <len.brown@intel.com>
To: Ian Stirling <linux-kernel@mauve.plus.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FEEC1@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FEEC1@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089052581.15653.24.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 14:36:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-28 at 04:00, Ian Stirling wrote:
> After I upgraded my server, I noticed eventually that the keyboard and
> mouse were not working properly.
> The mouse was completely dead, and the keyboard intermittent.
> Ok,  I thought, and replaced the motherboard.

> Any thoughts?
> 

try "acpi=off"
see if the /proc/interrupts is the same before/after the upgrade.
Also, a before/after dmesg might be helpful.

thanks,
-Len


