Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWFVXYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWFVXYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbWFVXYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:24:05 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:40685 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751045AbWFVXYD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:24:03 -0400
Message-ID: <449B268E.4000808@garzik.org>
Date: Thu, 22 Jun 2006 19:23:58 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@muc.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 build fix
References: <20060622205928.GA23801@havoc.gtf.org>	<20060622142430.3219f352.akpm@osdl.org>	<20060622223919.GB50270@muc.de> <20060622155943.27c98d61.akpm@osdl.org>
In-Reply-To: <20060622155943.27c98d61.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I don't think Jeff has sent us an example .config, but I hit this a few
> times too, before we fixed it.  I think this was all triggered by a Kconfig
> change in the AGP tree, so you wouldn't have seen it, but -mm did.

'make allmodconfig' on x86-64.  You can create this .config yourself :)

I think the tree suffers [sometimes due to me :(] when 'allyesconfig' 
and 'allmodconfig' stop working.

	Jeff


