Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVAOMal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVAOMal (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 07:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVAOMaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 07:30:39 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:37770 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262267AbVAOMae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 07:30:34 -0500
From: Jan De Luyck <lkml@kcore.org>
To: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ARP routing issue
Date: Sat, 15 Jan 2005 13:31:03 +0100
User-Agent: KMail/1.7.2
Cc: Steve Iribarne <steve.iribarne@dilithiumnetworks.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <B8561865DB141248943E2376D0E85215846787@DHOST001-17.DEX001.intermedia.net> <200501061711.59301.lkml@kcore.org> <41E84C1D.9060505@superbug.co.uk>
In-Reply-To: <41E84C1D.9060505@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501151331.04879.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 January 2005 23:47, James Courtier-Dutton wrote:
> That arp is perfectly OK.
> The routing table will cause the icmp echo packet to go from 10.216.0.xx
> to 10.0.24.xx via the 10.0.24.x network.
> The icmp echo response will return via the 10.0.22.x network back to the
> 10.216.0.xx network.
> So the paths in each direction are different.

Yes, but unfortunately I never ever receive the icmp echo reply, and the arp 
table always lists the ip as "incomplete". Nothing I try to do to with that 
interface (ssh/...) ever works.

Jan

-- 
Real Programmers don't eat quiche.  They eat Twinkies and Szechwan food.
