Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVA1AwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVA1AwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVA1AwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:52:05 -0500
Received: from alephnull.demon.nl ([212.238.201.82]:36520 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261340AbVA1Asa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:48:30 -0500
Date: Fri, 28 Jan 2005 01:48:25 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, greg@kroah.com,
       akpm@osdl.org
Subject: Re: [ANN] removal of certain net drivers coming soon: eepro100, xircom_tulip_cb, iph5526
Message-ID: <20050128004825.GA5359@xi.wantstofly.org>
References: <41F952F4.7040804@pobox.com> <20050127225725.F3036@flint.arm.linux.org.uk> <20050127153114.72be03e2.davem@davemloft.net> <20050128001430.C22695@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128001430.C22695@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 12:14:30AM +0000, Russell King wrote:

> The fact of the matter is that eepro100.c works on ARM, e100.c doesn't.

Hmmm, I recall e100 working fine on a Radisys ENP-2611, which has a
IXP2400 (xscale) in big-endian mode, running 2.6.  This particular
board had its root fs NFS-mounted and pumped several hundreds of
gigabytes through the NIC during a period of at least a few months,
and I never saw any problems.

Something tells me that the next time I try it, it won't work at all.


--L
