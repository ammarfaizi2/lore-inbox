Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264204AbTEOTlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbTEOTlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:41:21 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264204AbTEOTlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:41:19 -0400
Date: Thu, 15 May 2003 12:54:09 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Matt Porter <mporter@kernel.crashing.org>
cc: rmk@arm.linux.org.uk, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IRQ and resource for platform_device
In-Reply-To: <20030515113227.D7685@home.com>
Message-ID: <Pine.LNX.4.44.0305151253030.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> > Hmm, how would people feel if I suggested just:
> > 
> > 	int num_resources;
> > 	struct resource	*resources;
> > 
> > We have an IORESOURCE_IRQ, which can be used to indicate IRQ
> > resources.
> 
> I like that approach...simple and flexible.

Ditto. I've already added the original patch, but I'll gladly fix it up to 
this way..

Thanks,

	-pat

