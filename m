Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUHDExP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUHDExP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 00:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266846AbUHDExP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 00:53:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:51107 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266758AbUHDExE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 00:53:04 -0400
Subject: Re: Solving suspend-level confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@linuxmail.org
Cc: David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <1091593555.3191.48.camel@laptop.cunninghams>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408020938.17593.david-b@pacbell.net> <1091493486.7396.92.camel@gaston>
	 <200408031928.08475.david-b@pacbell.net>
	 <1091586381.3189.14.camel@laptop.cunninghams>
	 <1091587985.5226.74.camel@gaston>
	 <1091587929.3303.38.camel@laptop.cunninghams>
	 <1091592870.5226.80.camel@gaston>
	 <1091593555.3191.48.camel@laptop.cunninghams>
Content-Type: text/plain
Message-Id: <1091595125.5227.96.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 14:52:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm. That's what I was doing and do do for the remainder of the devices.
> Oh well. I'll give it a try again. What would 3 do? (There was a stage
> when all three implementations used 3; I've just played sheep in
> changing to 4).

3 would be S3 -> suspend to RAM. We may still want to fix drivers to
pass 4 as a PCI state though ;)

> It occurs to me that I'm going to need to extend the partial tree
> handling anyway. When I get this working, I'm going to want to resume
> only the storage devices, and haven't added code for that yet.
> 
> Regards,
> 
> Nigel
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

