Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVAFSEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVAFSEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbVAFSEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:04:31 -0500
Received: from dialpool1-19.dial.tijd.com ([62.112.10.19]:27274 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262961AbVAFR5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:57:43 -0500
From: Jan De Luyck <lkml@kcore.org>
To: rol@as2917.net
Subject: Re: ARP routing issue
Date: Thu, 6 Jan 2005 18:57:41 +0100
User-Agent: KMail/1.7.2
Cc: "'Steve Iribarne'" <steve.iribarne@dilithiumnetworks.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <200501061753.j06HrJ101272@tag.witbe.net>
In-Reply-To: <200501061753.j06HrJ101272@tag.witbe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501061857.42881.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 January 2005 18:53, Paul Rolland wrote:
> Hello,
>
> Have a look at /proc/sys/net/conf/XXX/arp_filter :
>
>
> arp_filter - BOOLEAN
>         1 - Allows you to have multiple network interfaces on the same
>         subnet, and have the ARPs for each interface be answered
>         based on whether or not the kernel would route a packet from
>         the ARP'd IP out that interface (therefore you must use source
>         based routing for this to work). In other words it allows control
>         of which cards (usually 1) will respond to an arp request.
>
>         0 - (default) The kernel can respond to arp requests with addresses
>         from other interfaces. This may seem wrong but it usually makes
>         sense, because it increases the chance of successful communication.
>         IP addresses are owned by the complete host on Linux, not by
>         particular interfaces. Only for more complex setups like load-
>         balancing, does this behaviour cause problems.
>
> Regards,
> Paul

I tried that actually, didn't change a thing.

Jan

-- 
Beware of computerized fortune-tellers!
