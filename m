Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVACFAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVACFAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 00:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVACFAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 00:00:08 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:4736
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261383AbVACFAC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 00:00:02 -0500
Date: Sun, 2 Jan 2005 21:00:01 -0800
From: Phil Oester <kernel@linuxace.com>
To: steve@perfectpc.co.nz
Cc: linux-kernel@vger.kernel.org
Subject: Re: iptable_nat: Unknown symbol need_ip_conntrack
Message-ID: <20050103050001.GA12500@linuxace.com>
References: <Pine.LNX.4.60.0501031641250.32415@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0501031641250.32415@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 04:52:39PM +1300, steve@perfectpc.co.nz wrote:
> 
> Hi,
> 
> I found these log in dmesg output but not sure how to get rid of them :-)
> 
> NET: Registered protocol family 17
> ip_tables: (C) 2000-2002 Netfilter core team
> ip_conntrack version 2.1 (511 buckets, 4088 max) - 332 bytes per conntrack
> ip_conntrack_ftp: Unknown symbol ip_conntrack_expect_related
...
> iptable_nat: Unknown symbol ip_conntrack_alter_reply
> 
> Kernel 2.6.10-ac2 . Apart from this, the system appears to be normal; 

Looks like a problem with your configuration/kernel build...I have no
such problems here on 2.6.10.

> 
> One more thing, the same system if I run 2.4.27 kernel I got a lot of
> message like:
> 
> MASQUERADE: Route sent us somewhere else.

Known problem fixed in 2.6.10.  Backport to 2.4.x unlikely...

Phil
