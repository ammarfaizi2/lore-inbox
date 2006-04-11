Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWDKL2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWDKL2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWDKL2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:28:05 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28588 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750754AbWDKL2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:28:04 -0400
Date: Tue, 11 Apr 2006 13:27:36 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andre Tomt <andre@tomt.net>
cc: Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org, vherva@vianova.fi,
       Patrick McHardy <kaber@trash.net>, netfilter@lists.netfilter.org,
       davem@davemloft.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
In-Reply-To: <4439350E.4060306@tomt.net>
Message-ID: <Pine.LNX.4.61.0604111326540.928@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
 <20060408200915.GN1686@vianova.fi> <44388908.6070602@trash.net>
 <20060409074313.GZ15954@vianova.fi> <20060409144416.GO1686@vianova.fi>
 <20060409144534.GN29797@vianova.fi> <87psjqg2nt.fsf@hades.wkstn.nix>
 <4439350E.4060306@tomt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Beeing bitten by such issues in the past, I always diff the old and the new
> config and look for anything suspicious going down.
>

My way:
  gzip -cd /proc/config.gz >.config
  make

The configurator will stop at any new config option, which includes 
xtables. :)


Jan Engelhardt
-- 
