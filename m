Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWIYL5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWIYL5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWIYL5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:57:47 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:6984 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1751490AbWIYL5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:57:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAEdgF0WLcgEBDQ
X-IronPort-AV: i="4.09,213,1157320800"; 
   d="scan'208"; a="3470015:sNHT30681384"
Date: Mon, 25 Sep 2006 13:57:44 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Andi Kleen <ak@suse.de>
Cc: David Miller <davem@davemloft.net>, jbglaw@lug-owl.de, kaber@trash.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
Message-ID: <20060925115744.GD23028@zlug.org>
References: <20060923120704.GA32284@zlug.org> <20060923121327.GH30245@lug-owl.de> <1159015118.5301.19.camel@jzny2> <20060923.163535.41636370.davem@davemloft.net> <p738xk8kzym.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p738xk8kzym.fsf@verdi.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 12:22:41PM +0200, Andi Kleen wrote:

> How would you convince those old LAN games to use a MTU < 1500 which
> is needed for the tunnel?  I bet they have the size hardcoded.

The tunnel provides an MTU of 1500. To guarantee this, it never sets the
DF flag in outgoing packets.

Joerg
