Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbUCHQwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 11:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUCHQwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 11:52:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53721 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262638AbUCHQwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 11:52:00 -0500
Date: Mon, 8 Mar 2004 12:02:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Yury V. Umanets" <umka@namesys.com>
Cc: Tvrtko =?iso-8859-2?Q?A=2E_Ur=B9ulin?= <tvrtko@croadria.com>,
       linux-kernel@vger.kernel.org, "Guo, Min" <min.guo@intel.com>,
       cgl_discussion@lists.osdl.org
Subject: Re: About Replaceable OOM Killer
Message-ID: <20040308110216.GD5352@openzaurus.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84035F1DD5@PDSMSX403.ccr.corp.intel.com> <200403011141.26724.tvrtko@croadria.com> <1078403388.3025.33.camel@firefly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078403388.3025.33.camel@firefly>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Though it hasn't been updated for a while because nobody cares...
> IMHO problem with OOM killer is that it always will do wrong choice. So,
> it should be either plugin based or allow to configure it and this
> means, that it will become more complex and buggy. Does not it mean,
> that OOM killer should be moved to user space?
> 
> How about to export OOM event to user space? It might be done in manner
> like hotplug script is used.

When you are OOM, you really can't exec userland script...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

