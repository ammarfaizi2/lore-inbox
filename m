Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424245AbWKIXOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424245AbWKIXOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424247AbWKIXOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:14:11 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:11906 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1424245AbWKIXOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:14:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=GFNSYt6uVbt2BFj8Q400dm9g2VeYhW7cv5E51o+IQbPexYc0rkU/73CSqwz2d
	8IpR0wAW5ch4WzLGIVrL1QspQ==
Date: Fri, 10 Nov 2006 00:14:08 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Martin Michlmayr <tbm@cyrius.com>,
       linux-kernel@vger.kernel.org
Subject: Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions)]
Message-ID: <20061109231408.GB6611@xi.wantstofly.org>
References: <20061107115940.GA23954@unjust.cyrius.com> <20061108203546.GA32247@kos.to> <20061109221338.GA17722@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109221338.GA17722@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 11:13:38PM +0100, Francois Romieu wrote:

> > I took 2.6.19-rc5 as there was no changes in this driver relative to -rc4. 
> > applied Francois's 0001-r8169-perform-a-PHY-reset.. and finally the
> > patch in this mail. And networking _does_not_ work on Thecus N2100.
> 
> It sucks.
> 
> Can you try against 2.6.18-rc4 the patch at:
> 
> http://www.fr.zoreil.com/people/francois/misc/20061109-2.6.18-rc4-r8169-test.patch
> 
> If it does not work, apply on top of 2.6.18-rc4 the serie available at:
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.18-rc4/r8169
> plus the attached patch.

Wouldn't it be easier for all of us if we'd arrange a shell account
on an n2100 for you?
