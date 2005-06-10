Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVFJMVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVFJMVJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 08:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVFJMVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 08:21:09 -0400
Received: from isilmar.linta.de ([213.239.214.66]:17319 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261350AbVFJMVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 08:21:07 -0400
Date: Fri, 10 Jun 2005 14:21:05 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Steve Snyder <swsnyder@insightbb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA still advised as modules?
Message-ID: <20050610122105.GA13931@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Steve Snyder <swsnyder@insightbb.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200506100811.17631.swsnyder@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506100811.17631.swsnyder@insightbb.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 08:11:17AM -0400, Steve Snyder wrote:
> Back in the 2.4.x kernel days I was advised to build the PCMCIA-related 
> drivers (pcmcia_core, ds, yenta_socket) as modules.  There were 
> supposedly problem with them being staticly built into the kernel.
> 
> Is this still the case?  Are there currently any drawbacks to having the 
> PCMCIA modules built into the kernel?

At least from 2.6.13 on, it will be much easier if you have the PCMCIA
"modules" built into the kernel, as you won't need userspace interaction any
longer (except on old yenta_socket bridges during startup, but that's a
different story). Therefore, I do not see any drawbacks to having the PCMCIA
modules built into the kernel.

	Dominik
