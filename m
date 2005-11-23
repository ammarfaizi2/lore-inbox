Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVKWTTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVKWTTH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVKWTTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:19:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932209AbVKWTTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:19:04 -0500
Date: Wed, 23 Nov 2005 11:17:48 -0800
From: Chris Wright <chrisw@osdl.org>
To: Harald Welte <laforge@netfilter.org>
Cc: Krzysztof Oledzki <ole@ans.pl>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [patch 13/23] [PATCH] [NETFILTER] ctnetlink: Fix oops when no ICMP ID info in message
Message-ID: <20051123191747.GP5856@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain> <20051122210804.GN28140@shell0.pdx.osdl.net> <Pine.LNX.4.64.0511230023310.15479@bizon.gios.gov.pl> <20051123065921.GK31478@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123065921.GK31478@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Harald Welte (laforge@netfilter.org) wrote:
> On Wed, Nov 23, 2005 at 12:31:55AM +0100, Krzysztof Oledzki wrote:
> > On Tue, 22 Nov 2005, Chris Wright wrote:
> > 
> > >-stable review patch.  If anyone has any objections, please let us know.
> > 
> > It seems we have two different patches here.
> 
> yes, it seems like two independent patches slipped into the one patch
> that was submitted.  I detected that error for mainline, but forgot that
> the same patch was submitted for stable.
> 
> So the first part (as pointed out by Krzyzstof) is not a bugfix, but a
> cosmetic fix.  
> 
> I therefore request reverting this patch '13', and instead applying the version
> below, the one that contains only the real fix (as indicated in the
> changelog)

Thanks Harald, I dropped the old patch and replaced with this one.

thanks,
-chris
