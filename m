Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265577AbTFMXHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbTFMXHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:07:10 -0400
Received: from dp.samba.org ([66.70.73.150]:40406 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265577AbTFMXHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:07:09 -0400
Date: Sat, 14 Jun 2003 09:18:36 +1000
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: haveblue@us.ibm.com, hdierks@us.ibm.com, scott.feldman@intel.com,
       dwg@au1.ibm.com, linux-kernel@vger.kernel.org, milliner@us.ibm.com,
       ricardoz@us.ibm.com, twichell@us.ibm.com, netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
Message-ID: <20030613231836.GD32097@krispykreme>
References: <OF0078342A.E131D4B1-ON85256D44.0051F7C0@pok.ibm.com> <1055521263.3531.2055.camel@nighthawk> <20030613223841.GB32097@krispykreme> <20030613.154634.74748085.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613.154634.74748085.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Not really... one retransmit and the TCP header size grows
> due to the SACK options.

OK scratch that idea.

> I find it truly bletcherous what you're trying to do here.

I think so too, but its hard to ignore ~100Mbit/sec in performance.

> Why not instead find out if it's possible to have the e1000
> fetch the entire cache line where the first byte of the packet
> resides?  Even ancient designes like SunHME do that.

Rusty and I were wondering why the e1000 didnt do that exact thing.

Scott: is it possible to enable such a thing?

Anton
