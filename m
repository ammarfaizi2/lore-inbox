Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbULTVPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbULTVPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbULTVPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:15:05 -0500
Received: from waste.org ([216.27.176.166]:51349 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261645AbULTVPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:15:02 -0500
Date: Mon, 20 Dec 2004 13:14:19 -0800
From: Matt Mackall <mpm@selenic.com>
To: Mark Broadbent <markb@wetlettuce.com>
Cc: romieu@fr.zoreil.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041220211419.GC5974@waste.org>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com> <20041216211024.GK2767@waste.org> <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com> <20041217215752.GP2767@waste.org> <20041217233524.GA11202@electric-eye.fr.zoreil.com> <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 09:42:08AM -0000, Mark Broadbent wrote:
> 
> Exactly the same happens, I still get a 'NMI Watchdog detected LOCKUP'
> with the r8169 device using the above patch on top of 2.6.10-rc3-bk10.

Ok, that suggests a problem localized to netpoll itself. Do you have
spinlock debugging turned on by any chance? 

-- 
Mathematics is the supreme nostalgia of our time.
