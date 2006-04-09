Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWDIQXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWDIQXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 12:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWDIQXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 12:23:30 -0400
Received: from mail1.skjellin.no ([80.239.42.67]:36573 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S1750706AbWDIQX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 12:23:29 -0400
Message-ID: <4439350E.4060306@tomt.net>
Date: Sun, 09 Apr 2006 18:23:42 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org
CC: vherva@vianova.fi, Patrick McHardy <kaber@trash.net>,
       netfilter@lists.netfilter.org, davem@davemloft.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>	<20060408200915.GN1686@vianova.fi> <44388908.6070602@trash.net>	<20060409074313.GZ15954@vianova.fi> <20060409144416.GO1686@vianova.fi>	<20060409144534.GN29797@vianova.fi> <87psjqg2nt.fsf@hades.wkstn.nix>
In-Reply-To: <87psjqg2nt.fsf@hades.wkstn.nix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:
> I cetainly did. A simple `make oldconfig' ends up zapping pretty much
> all the old iptables CONFIG_ options, so you end up with not much of
> iptables or netfilter left.
> 
> I must admit not quite understanding why the xtables stuff is needed:
> I thought that was needed for userspace connection tracking, which
> while it sounds cool isn't something I'm using yet.
> 

Beeing bitten by such issues in the past, I always diff the old and the 
new config and look for anything suspicious going down.

-- 
André Tomt
