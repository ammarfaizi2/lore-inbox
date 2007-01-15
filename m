Return-Path: <linux-kernel-owner+w=401wt.eu-S1751762AbXAOAf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbXAOAf0 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbXAOAf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:35:26 -0500
Received: from nef2.ens.fr ([129.199.96.40]:1230 "EHLO nef2.ens.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbXAOAfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:35:24 -0500
Date: Mon, 15 Jan 2007 01:35:08 +0100
From: David Madore <david.madore@ens.fr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] netfilter: implement TCPMSS target for IPv6
Message-ID: <20070115003508.GA8085@clipper.ens.fr>
References: <20070114192011.GA6270@clipper.ens.fr> <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.9 (nef2.ens.fr [129.199.96.32]); Mon, 15 Jan 2007 01:35:09 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 09:10:45PM +0100, Jan Engelhardt wrote:
> On Jan 14 2007 20:20, David Madore wrote:
> >Implement TCPMSS target for IPv6 by shamelessly copying from
> >Marc Boucher's IPv4 implementation.
> 
> Would not it be worthwhile to merge ipt_TCPMSS and
> ip6t_TCPMSS to xt_TCPMSS instead?

It may be, but I'm afraid that's outside my competence.  I happened to
need ip6t_TCPMSS badly and soon, so I went for the quickest solution.
Of course, I'd appreciate it if someone were to do it in a better way.

Happy hacking,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
