Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275322AbTHSDV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 23:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275319AbTHSDV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 23:21:58 -0400
Received: from evrtwa1-ar2-4-33-045-084.evrtwa1.dsl-verizon.net ([4.33.45.84]:55789
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S275316AbTHSDV4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 23:21:56 -0400
Message-ID: <3F41979C.3070408@candelatech.com>
Date: Mon, 18 Aug 2003 20:21:00 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: "David S. Miller" <davem@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, bloemsaa@xs4all.nl, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
References: <Pine.LNX.3.96.1030818171100.2101C-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030818171100.2101C-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Okay, I'll show my ignorance and ask... the Documentation for arp_filter
> says source routing must be used. Is there some flag I'm missing, or a way
> to avoid having a rule per address, or is the 8 bit rule number larger in
> 2.6, or ??? Or is having a lot of IPs on one machine not an imaginable
> case?

Last response I got was that one would have to hack the netlink api to get
a bigger index because the design (and rfc, unfortunately) describe the
field as only 8 bits.  I never did hear a response to my comment that this
was inadequate in this age of vlans...

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


