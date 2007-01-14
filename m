Return-Path: <linux-kernel-owner+w=401wt.eu-S1751659AbXANUMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXANUMf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 15:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXANUMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 15:12:35 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:40993 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656AbXANUMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 15:12:34 -0500
Date: Sun, 14 Jan 2007 21:10:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Madore <david.madore@ens.fr>
cc: netfilter-devel@lists.netfilter.org, kaber@trash.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] netfilter: implement TCPMSS target for IPv6
In-Reply-To: <20070114192011.GA6270@clipper.ens.fr>
Message-ID: <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr>
References: <20070114192011.GA6270@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 14 2007 20:20, David Madore wrote:
>
>Implement TCPMSS target for IPv6 by shamelessly copying from
>Marc Boucher's IPv4 implementation.
>
>Signed-off-by: David A. Madore <david.madore@ens.fr>

Would not it be worthwhile to merge ipt_TCPMSS and
ip6t_TCPMSS to xt_TCPMSS instead?


	-`J'
-- 
