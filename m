Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVLAU2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVLAU2u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVLAU2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:28:50 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:2742 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932439AbVLAU2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:28:49 -0500
Subject: Re: Fw: crash on x86_64 - mm related?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Ryan Richter <ryan@tau.solarneutrino.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org>
References: <20051129092432.0f5742f0.akpm@osdl.org>
	 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local>
	 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 14:28:02 -0600
Message-Id: <1133468882.5232.14.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 11:38 -0800, Linus Torvalds wrote:
> Ryan, can you test 2.6.15-rc4 and report what it does?
> 
> The "Bad page state" messages may (should) remain, but the crashes should 
> be gone and the machine should hopefully continue functioning fine. And, 
> perhaps more importantly, you should hopefully have a _new_ message about 
> incomplete pfn mappings that should help pinpoint which driver causes 
> this..

On a side note, I have Kai's patch in the scsi-rc-fixes tree which I'm
getting ready to push.  Can we get a consensus on whether it should be
removed before I merge upwards?

Thanks,

James


