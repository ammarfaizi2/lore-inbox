Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUDMEVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUDMEVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:21:39 -0400
Received: from 64-60-242-179.cust.telepacific.net ([64.60.242.179]:63301 "EHLO
	jm.kir.nu") by vger.kernel.org with ESMTP id S263295AbUDMEVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:21:23 -0400
Date: Mon, 12 Apr 2004 21:21:03 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Ga?l Le Mignot <kilobug@freesurf.fr>,
       linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: Any plan for inclusion of linux-wlan-ng ?
Message-ID: <20040413042103.GB3670@jm.kir.nu>
References: <plopm3lll26bsg.fsf@drizzt.kilobug.org> <20040411164011.GA21257@kroah.com> <4079B313.7010907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4079B313.7010907@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2004 at 05:05:23PM -0400, Jeff Garzik wrote:

> I had hoped that HostAP would be submitted, and that could form the 
> basis of a common 802.11 stack, but I haven't heard anything about that 
> in many weeks.

It will be.. WPA2 distracted me from this preparation, but I will try to
get back to cleaning up the Host AP driver for 2.6. Actually, I might
consider submitting it first without CCMP (AES-counter with CBC-MAC),
because that is the part that is likely to take most time to convert for
crypto API and this can be easily added separately.

-- 
Jouni Malinen                                            PGP id EFC895FA
