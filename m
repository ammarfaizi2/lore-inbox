Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTENXad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTENXad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:30:33 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:42210 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263171AbTENXac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:30:32 -0400
Date: Thu, 15 May 2003 00:43:59 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: jt@hpl.hp.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>, Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030514234359.GB9898@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, jt@hpl.hp.com,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>,
	David Gibson <hermes@gibson.dropbear.id.au>,
	Benjamin Reed <breed@almaden.ibm.com>,
	Javier Achirica <achirica@ttd.net>,
	Jouni Malinen <jkmaline@cc.hut.fi>
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514233235.GA11581@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 04:32:35PM -0700, Jean Tourrilhes wrote:

 > 	While we are on the subject : a few months ago, Javier added
 > support for MIC to the airo driver. It's basically crypto based on
 > AES. You refused to include that part in the kernel because crypto was
 > not accepted in the kernel.
 > 	Fast forward : today we have crypto in the 2.5.X kernel. Does
 > this mean that you would have no objection accepting a patch from
 > Javier including the crypto part ?

Sounds like it would be better to get it using the in-kernel crypto
stuff rather than reimplementing its own routines. Same for the HostAP
driver.
 
		Dave
