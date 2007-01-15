Return-Path: <linux-kernel-owner+w=401wt.eu-S932106AbXAOIjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbXAOIjk (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 03:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbXAOIjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 03:39:40 -0500
Received: from stinky.trash.net ([213.144.137.162]:53034 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbXAOIjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 03:39:39 -0500
Message-ID: <45AB3DCA.9020204@trash.net>
Date: Mon, 15 Jan 2007 09:39:38 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: David Madore <david.madore@ens.fr>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] netfilter: implement TCPMSS target for IPv6
References: <20070114192011.GA6270@clipper.ens.fr> <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> On Jan 14 2007 20:20, David Madore wrote:
> 
>>Implement TCPMSS target for IPv6 by shamelessly copying from
>>Marc Boucher's IPv4 implementation.
>>
>>Signed-off-by: David A. Madore <david.madore@ens.fr>
> 
> 
> Would not it be worthwhile to merge ipt_TCPMSS and
> ip6t_TCPMSS to xt_TCPMSS instead?

I'm not sure how well that will work (the IPv4/IPv6-specific stuff
is spread over the entire target function), but its worth a try.

