Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWIYMQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWIYMQY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWIYMQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:16:24 -0400
Received: from mx1.suse.de ([195.135.220.2]:4524 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751072AbWIYMQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:16:23 -0400
From: Andi Kleen <ak@suse.de>
To: Joerg Roedel <joro-lkml@zlug.org>
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
Date: Mon, 25 Sep 2006 14:16:15 +0200
User-Agent: KMail/1.9.3
Cc: David Miller <davem@davemloft.net>, jbglaw@lug-owl.de, kaber@trash.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060923120704.GA32284@zlug.org> <p738xk8kzym.fsf@verdi.suse.de> <20060925115744.GD23028@zlug.org>
In-Reply-To: <20060925115744.GD23028@zlug.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609251416.15738.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 September 2006 13:57, Joerg Roedel wrote:
> On Mon, Sep 25, 2006 at 12:22:41PM +0200, Andi Kleen wrote:
> 
> > How would you convince those old LAN games to use a MTU < 1500 which
> > is needed for the tunnel?  I bet they have the size hardcoded.
> 
> The tunnel provides an MTU of 1500. To guarantee this, it never sets the
> DF flag in outgoing packets.

This means it will multiply all full sized packets. That sounds horrible.

-Andi
