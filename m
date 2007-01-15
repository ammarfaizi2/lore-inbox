Return-Path: <linux-kernel-owner+w=401wt.eu-S932186AbXAOKSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbXAOKSQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 05:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbXAOKSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 05:18:16 -0500
Received: from stinky.trash.net ([213.144.137.162]:55236 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbXAOKSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 05:18:15 -0500
Message-ID: <45AB54E5.6060103@trash.net>
Date: Mon, 15 Jan 2007 11:18:13 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: David Madore <david.madore@ens.fr>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] netfilter: implement TCPMSS target for IPv6
References: <20070114192011.GA6270@clipper.ens.fr> <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr> <45AB3DCA.9020204@trash.net> <Pine.LNX.4.61.0701151109540.32479@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0701151109540.32479@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> On Jan 15 2007 09:39, Patrick McHardy wrote:
> 
>>I'm not sure how well that will work (the IPv4/IPv6-specific stuff
>>is spread over the entire target function), but its worth a try.
> 
> 
> "Nothing is impossible." Since you happened to take that one for
> yourself... well here's a q: would a patch be accepted that changes
> all ipt and ip6t modules to the new xt? Even if a module is only for
> ipv4 or ipv6, I think it makes sense to reduce the number of
> different *t structures floating around.


If you're talking about using the xt-structures in net/ipv[46]/netfilter
and removing the ipt/ip6t-wrappers, that would make sense IMO.

