Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUFIUqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUFIUqD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUFIUqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:46:02 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:58892 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265971AbUFIUpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:45:54 -0400
Date: Wed, 9 Jun 2004 22:45:17 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Norman Weathers <norman.r.weathers@conocophillips.com>
Cc: sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.26 SMP lockup problem
Message-ID: <20040609204516.GB29808@alpha.home.local>
References: <200406081757.28770.norman.r.weathers@conocophillips.com> <1086736002.3346.56.camel@persist.az.mvista.com> <200406090809.08919.norman.r.weathers@conocophillips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406090809.08919.norman.r.weathers@conocophillips.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 09, 2004 at 08:09:08AM -0500, Norman Weathers wrote:
> 
> That's the funny thing about this lockup... I can't even get a traceback from 
> the serial console.  Here is my boot command line:
> 
> auto BOOT_IMAGE=2.4.26 ro root=301 noapic console=tty0 console=ttyS0,115200n8 
> panic=60 nmi_watchdog=1
> 
> I have the watchdog turned on (built in to the kernel, not a module), and have 
> been using the above command line, but still get no oops and cannot get a 
> traceback...

for a yet unknown reason, my board (asus a7m266d) ignores nmi_watchdog=1
but is fine with 2. Might be worth trying.

Regards
Willy
