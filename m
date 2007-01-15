Return-Path: <linux-kernel-owner+w=401wt.eu-S932180AbXAOKN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbXAOKN6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 05:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbXAOKN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 05:13:58 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:40152 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932180AbXAOKN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 05:13:57 -0500
Date: Mon, 15 Jan 2007 11:12:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Patrick McHardy <kaber@trash.net>
cc: David Madore <david.madore@ens.fr>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] netfilter: implement TCPMSS target for IPv6
In-Reply-To: <45AB3DCA.9020204@trash.net>
Message-ID: <Pine.LNX.4.61.0701151109540.32479@yvahk01.tjqt.qr>
References: <20070114192011.GA6270@clipper.ens.fr>
 <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr> <45AB3DCA.9020204@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 15 2007 09:39, Patrick McHardy wrote:
>> On Jan 14 2007 20:20, David Madore wrote:
>> 
>>>Implement TCPMSS target for IPv6 by shamelessly copying from
>>>Marc Boucher's IPv4 implementation.
>>>
>>>Signed-off-by: David A. Madore <david.madore@ens.fr>
>> 
>> 
>> Would not it be worthwhile to merge ipt_TCPMSS and
>> ip6t_TCPMSS to xt_TCPMSS instead?
>
>I'm not sure how well that will work (the IPv4/IPv6-specific stuff
>is spread over the entire target function), but its worth a try.

"Nothing is impossible." Since you happened to take that one for
yourself... well here's a q: would a patch be accepted that changes
all ipt and ip6t modules to the new xt? Even if a module is only for
ipv4 or ipv6, I think it makes sense to reduce the number of
different *t structures floating around.


	-`J'
-- 
