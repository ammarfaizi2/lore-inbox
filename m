Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUHRHFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUHRHFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 03:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUHRHFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 03:05:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:31913 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262380AbUHRHFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 03:05:19 -0400
Subject: Re: [patch] enums to clear suspend-state confusion
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <20040818061227.GA7854@elf.ucw.cz>
References: <20040812120220.GA30816@elf.ucw.cz>
	 <20040817212510.GA744@elf.ucw.cz> <20040817152742.17d3449d.akpm@osdl.org>
	 <20040817223700.GA15046@elf.ucw.cz> <20040817161245.50dd6b96.akpm@osdl.org>
	 <20040818002711.GD15046@elf.ucw.cz> <1092794687.10506.169.camel@gaston>
	 <20040818061227.GA7854@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092812149.9932.180.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 16:55:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, that's exactly what I did... Unfortunately typedef means ugly
> code. So I'll just switch it back to enum system_state, and lets care
> about device power managment when it hits us, okay?

I don't agree... with this approach, we'll have to change all drivers
_twice_ when we move to something more descriptive than a scalar

Ben.


