Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWIHToQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWIHToQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWIHToQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:44:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4271 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750773AbWIHToO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:44:14 -0400
Date: Fri, 8 Sep 2006 12:44:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm1
Message-Id: <20060908124411.aa96fb7b.akpm@osdl.org>
In-Reply-To: <20060908193041.GA18966@amd64.of.nowhere>
References: <20060908011317.6cb0495a.akpm@osdl.org>
	<20060908193041.GA18966@amd64.of.nowhere>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 21:30:41 +0200
thunder7@xs4all.nl wrote:

> From: Andrew Morton <akpm@osdl.org>
> Date: Fri, Sep 08, 2006 at 01:13:17AM -0700
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> > 
> This throws an oops on my IBM Thinkpad T23 notebook. Some parts scroll
> off the screen, but the visible stack trace goes like this:
> 
> savagefb_probe_i2c_connector
> savagefb_probe
> pci_match_device
> ....
> EIP: fb_ddc_read ....
> 
> .config and dmesg attached. 2.6.18-rc2-mm1 works just fine here.

We'd really need to see that trace, please.  netconsole is worth setting
up, if you have another machine on the LAN.
