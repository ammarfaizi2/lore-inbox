Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbRGXMJf>; Tue, 24 Jul 2001 08:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267483AbRGXMJ0>; Tue, 24 Jul 2001 08:09:26 -0400
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:23791 "HELO
	duron.intern.kubla.de") by vger.kernel.org with SMTP
	id <S267466AbRGXMJT>; Tue, 24 Jul 2001 08:09:19 -0400
Date: Tue, 24 Jul 2001 14:09:16 +0200
From: Dominik Kubla <kubla@sciobyte.de>
To: Paul Jakma <paul@clubi.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Arp problem
Message-ID: <20010724140916.F31198@intern.kubla.de>
In-Reply-To: <Pine.LNX.4.33.0107240208460.10839-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107240208460.10839-100000@fogarty.jakma.org>
User-Agent: Mutt/1.3.18i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 02:10:33AM +0100, Paul Jakma wrote:

> if i have 2 logical subnets on the wire, linux listening on both, is
> there any way to get linux to fully route packets between the 2
> subnets?
> 
> at the moment it just issues a icmp_redirect, which isn't good enough
> for certain hosts (eg win9x at least).

Solaris 8 ditto.

IMHO this is definitely a linux bug, since the kernel can not now about
the true network topology: Cable sharing might just be used for this one
system doing the routing/filtering/whatever between the two networks,
while all the other hosts are in seperated switch segments. Not a common
setup but you will see this often enough: head count is already 2... ;-)

Dominik
-- 
          A lovely thing to see:                   Kobayashi Issa
     through the paper window's holes               (1763-1828)
                the galaxy.               [taken from: David Brin - Sundiver]
