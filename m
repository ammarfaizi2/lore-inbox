Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVBQVZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVBQVZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 16:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVBQVZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 16:25:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:38529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261171AbVBQVZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 16:25:09 -0500
Date: Thu, 17 Feb 2005 13:25:06 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-os <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Needlessly global functions static...."
Message-ID: <20050217212506.GA21662@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0502171607500.18275@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502171607500.18275@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* linux-os (linux-os@analogic.com) wrote:
> 
> Hello,
> Tell me. When all those kernel functions are made static
> how does one use a kernel debugger? How does the OOPS
> get decoded if nothing is in /proc/kallsyms or System.map???

static != inline.  Locally scoped symbols, 't',  and global, 'T', 
are in kallsyms or System.map.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
