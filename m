Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVHDRLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVHDRLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVHDRIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:08:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:6807 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262636AbVHDRIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:08:04 -0400
Date: Thu, 4 Aug 2005 19:08:03 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
Message-ID: <20050804170803.GB8266@wotan.suse.de>
References: <20050730181418.65caed1f.pj@sgi.com> <Pine.LNX.4.62.0507301814540.31359@graphe.net> <20050730190126.6bec9186.pj@sgi.com> <Pine.LNX.4.62.0507301904420.31882@graphe.net> <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net> <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net> <20050804142942.GY8266@wotan.suse.de> <Pine.LNX.4.62.0508040922110.6650@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508040922110.6650@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This piece here only does conversion to a string representation so it 
> > > should not be affected by locking issues. Processes need to do proper 
> > > locking when using the conversion functions.
> > 
> > It's useless.
> 
> So your point of view is that there will be no control and monitoring of 
> the memory usage and policies?

External control is implemented for named objects and for process policy.
A process can also monitor its own policies if it wants.

I think the payoff for external monitoring of policies vs complexity 
and cleanliness of interface and long term code impact is too bad to make 
it an attractive option.


-Andi

