Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVHLPij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVHLPij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 11:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVHLPij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 11:38:39 -0400
Received: from ns2.suse.de ([195.135.220.15]:38358 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751199AbVHLPii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 11:38:38 -0400
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel spams syslog every 10 sec with w1 debug
References: <20050812150748.GA6774@suse.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Aug 2005 17:38:37 +0200
In-Reply-To: <20050812150748.GA6774@suse.de.suse.lists.linux.kernel>
Message-ID: <p73fytf2miq.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> writes:

> Bug 104020 - kernel spams syslog every 10 sec with: w1_driver w1_bus_master1: No devices present on the wire.
> 
> After installing 10.0 B1, I found this in my syslog: 
> Aug 10 23:40:06 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 
> Aug 10 23:40:16 linux kernel: w1_driver w1_bus_master1: No devices present on the wire. 

More interesting is why this thing is running at all.
It shouldn't. 

-Andi
