Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTEWO2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 10:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbTEWO2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 10:28:20 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:27813 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263600AbTEWO2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 10:28:19 -0400
Subject: Re: irtty_sir cannot be unloaded
From: Stian Jordet <liste@jordet.nu>
To: Martin Diehl <lists@mdiehl.de>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305230830490.14825-100000@notebook.home.mdiehl.de>
References: <Pine.LNX.4.44.0305230830490.14825-100000@notebook.home.mdiehl.de>
Content-Type: text/plain
Message-Id: <1053700929.711.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 23 May 2003 16:42:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 23.05.2003 kl. 08.38 skrev Martin Diehl:
> On 23 May 2003, Stian Jordet wrote:
> 
> > > 	Disable HotPlug in your kernel and recompile. Various network
> > > people have been notified of this bug, but this is not an easy one.
> > 
> > You were right, this was the problem. Then I just have to choose what I
> > need the most; irda or pcmcia :)
> 
> I bet pcmcia works without hotplug ;-)
I might be blind or stupid (or both), but when I disable hotplug, I
can't enable cardbus at all. :) But davem's patch worked just fine :)
*happy*

Best regards,
Stian

