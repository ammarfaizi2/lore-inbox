Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267669AbUIOWiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267669AbUIOWiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUIOWfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:35:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54931 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267685AbUIOWbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:31:25 -0400
Message-ID: <4148C2B0.20504@pobox.com>
Date: Wed, 15 Sep 2004 18:31:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: alan@lxorguk.ukuu.org.uk, paul@clubi.ie, netdev@oss.sgi.com,
       leonid.grossman@s2io.com, linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
References: <4148991B.9050200@pobox.com>	<Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>	<1095275660.20569.0.camel@localhost.localdomain>	<4148A90F.80003@pobox.com>	<20040915140123.14185ede.davem@davemloft.net>	<20040915210818.GA22649@havoc.gtf.org> <20040915141346.5c5e5377.davem@davemloft.net>
In-Reply-To: <20040915141346.5c5e5377.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Plus we have things like TSO too but that doesn't require a full Linux
> instance to realize on a networking port.
> Simple silicon implements this already.
> I don't see how that differs from your "big MTU" ideas.


WRT MTU:  if the card is a buffering endpoint, rather than a 
passthrough, the card deals with Path MTU and fragmentation, leaving the 
card<->host MTU at 64K, getting nice big fat frames.

	Jeff


