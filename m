Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVHLPk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVHLPk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 11:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVHLPk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 11:40:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:56790 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932175AbVHLPk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 11:40:29 -0400
Date: Fri, 12 Aug 2005 17:40:27 +0200
From: Olaf Hering <olh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel spams syslog every 10 sec with w1 debug
Message-ID: <20050812154027.GA7802@suse.de>
References: <20050812150748.GA6774@suse.de.suse.lists.linux.kernel> <p73fytf2miq.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <p73fytf2miq.fsf@verdi.suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Aug 12, Andi Kleen wrote:

> Olaf Hering <olh@suse.de> writes:
> 
> > Bug 104020 - kernel spams syslog every 10 sec with: w1_driver w1_bus_master1: No devices present on the wire.
> > 
> > After installing 10.0 B1, I found this in my syslog: 
> > Aug 10 23:40:06 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 
> > Aug 10 23:40:16 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 
> 
> More interesting is why this thing is running at all.
> It shouldn't. 

Maybe these cables can be plugged in at any time and the driver is
polling. Havent looked how things work.
