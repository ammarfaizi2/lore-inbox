Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUIOVbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUIOVbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUIOV2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:28:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59276 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267542AbUIOVYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:24:05 -0400
Message-ID: <4148B2E5.50106@pobox.com>
Date: Wed, 15 Sep 2004 17:23:49 -0400
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
> On Wed, 15 Sep 2004 17:08:18 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>There's nothing inherently wrong with sticking a computer running
>>Linux inside another computer ;-)
> 
> 
> And we already support that :-)
> 
> Plus we have things like TSO too but that doesn't require a full Linux
> instance to realize on a networking port.
> Simple silicon implements this already.
> I don't see how that differs from your "big MTU" ideas.


Part of this is about how to talk to business people.... marketing.

The typical definition of TOE is "offload 90+% of the net stack", as 
opposed to "TCP assist", which is stuff like TSO.

If people ask about how to support TOE in Linux, you can say "sure, we 
_already_ support TOE, just stick Linux on a PCI card" rather than "no 
we don't support it."

And wha-la, we support TOE with zero code changes ;-)

	Jeff, who would love to have a bunch of Athlons
	on PCI cards to play with.


