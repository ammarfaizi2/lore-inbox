Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbVIAViP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbVIAViP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbVIAViO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:38:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51468 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030411AbVIAViN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:38:13 -0400
Date: Thu, 1 Sep 2005 22:38:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Ben Dooks <ben@fluff.org.uk>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial driver (serial_core.c) status messages should be set to KERN_INFO
Message-ID: <20050901223804.D29754@flint.arm.linux.org.uk>
Mail-Followup-To: Jiri Slaby <jirislaby@gmail.com>,
	Ben Dooks <ben@fluff.org.uk>, Alon Bar-Lev <alon.barlev@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43177223.8030403@gmail.com> <431766C2.2020604@gmail.com> <20050901204610.GA1816@home.fluff.org> <43176CC4.7040105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43176CC4.7040105@gmail.com>; from jirislaby@gmail.com on Thu, Sep 01, 2005 at 11:04:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 11:04:04PM +0200, Jiri Slaby wrote:
> ok, ok, but isn't this a little bit racy (so you can see dev_name and 
> line, then another driver's info and then " at ", then something else...)

I think you'll find things are serialised.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
