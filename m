Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVDNGyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVDNGyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 02:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVDNGyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 02:54:10 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:26280 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261441AbVDNGyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 02:54:06 -0400
Date: Thu, 14 Apr 2005 08:54:05 +0200
From: bert hubert <ahu@ds9a.nl>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iproute/iptables best?
Message-ID: <20050414065404.GA10880@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
References: <200504132335.12324.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504132335.12324.gene.heskett@verizon.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 11:35:12PM -0400, Gene Heskett wrote:
> How can we make the reply to an action go back out through the route 
> it came in on?  As it exists, queries, ssh sessions etc coming in 
> thru a vpn from one router are being replied to on the default 
> gateways card that hits the other network.

Sometimes Linux can't (and shouldn't) figure out the "right" interface. In
this case, you need policy routing:

http://lartc.org/howto/lartc.rpdb.multiple-links.html
http://lartc.org/howto/lartc.rpdb.html

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
