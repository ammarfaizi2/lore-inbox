Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTDDRPd (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTDDROt (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:14:49 -0500
Received: from siaag1ac.compuserve.com ([149.174.40.5]:3277 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S263867AbTDDRFX (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 12:05:23 -0500
Date: Fri, 4 Apr 2003 12:13:23 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: my linux does not accept redirects
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304041216_MC3-1-3301-C859@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The ARP protocol finds the physical address, the IEEE
> station address of a particular host and talks to it using
> that address. If the IP address is behind a router, then
> the router answers the ARP request with its physical address.


Damn Cisco and their default proxy ARP settings...

While learning to use iproute2 I managed to set my local eth0
interface as the default route.  Boy was I suprised to see the
router's ARP reply for a network address far, far away!

--
 Chuck
