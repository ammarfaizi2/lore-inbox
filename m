Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265356AbUGGTiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUGGTiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUGGTiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:38:07 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:6370 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265356AbUGGTiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:38:03 -0400
Date: Wed, 7 Jul 2004 21:38:02 +0200
From: bert hubert <ahu@ds9a.nl>
To: Jamie Lokier <jamie@shareable.org>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-ID: <20040707193802.GA8117@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jamie Lokier <jamie@shareable.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	"David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20040701140406.62dfbc2a.davem@redhat.com> <20040702013225.GA24707@conectiva.com.br> <20040706093503.GA8147@outpost.ds9a.nl> <20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net> <20040706194034.GA11021@mail.shareable.org> <20040706131235.10b5afa8.davem@redhat.com> <20040706224453.GA6694@outpost.ds9a.nl> <20040706154907.422a6b73.davem@redhat.com> <20040707110653.7c49bef1@dell_ss3.pdx.osdl.net> <20040707193125.GA17266@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707193125.GA17266@mail.shareable.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 08:31:25PM +0100, Jamie Lokier wrote:

> So why do we set a larger window scale than necessary?
> Is it to support (a)?

It might be useful to shake out the bugs of the internet - so far I have
indications that at least on residential ADSL router is responsible, it
removes wscale when doing TCP portforwarding.

If and when we decide to do larger rmem than now, we might have a better
chance.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
