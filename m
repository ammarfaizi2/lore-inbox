Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUGIUYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUGIUYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 16:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUGIUYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 16:24:53 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:14746 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261236AbUGIUYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 16:24:50 -0400
Date: Fri, 9 Jul 2004 22:24:49 +0200
From: bert hubert <ahu@ds9a.nl>
To: Redeeman <lkml@metanurb.dk>
Cc: "David S. Miller" <davem@redhat.com>,
       Stephen Hemminger <shemminger@osdl.org>, jamie@shareable.org,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       LKML Mailinglist <linux-kernel@vger.kernel.org>,
       ALESSANDRO.SUARDI@ORACLE.COM
Subject: Re: preliminary conclusions regarding window size issues
Message-ID: <20040709202449.GA21348@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Redeeman <lkml@metanurb.dk>, "David S. Miller" <davem@redhat.com>,
	Stephen Hemminger <shemminger@osdl.org>, jamie@shareable.org,
	netdev@oss.sgi.com, linux-net@vger.kernel.org,
	LKML Mailinglist <linux-kernel@vger.kernel.org>,
	ALESSANDRO.SUARDI@ORACLE.COM
References: <20040707232757.GA14471@outpost.ds9a.nl> <1089323824.27085.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089323824.27085.6.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 11:57:04PM +0200, Redeeman wrote:
> hey bert, a little update on things.
> for 2 days ago, when we chatted on irc first, i could reach lkml.org,
> however, i had played abit with various settings.. i cant get that
> working now, neither can i get tcpdump to give me info....

This has been resolved as an IPv6 routing issue - lkml.org also has an AAAA
record but Redeeman's IPv6 is not fully functional.

Regarding the packages.gentoo.org kernel, 'NQWOLK' has been coined :-)

Alessandro, shall we try the MSS clamp route to further determine what is
going on? With packages.gentoo.org the TCP behaviour confirmed that a 'smart
firewall' was to blame and not something that stamped over the wscale,
perhaps we can narrow down your problem as well.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
