Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVAWIKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVAWIKq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 03:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVAWIKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 03:10:46 -0500
Received: from brn35.neoplus.adsl.tpnet.pl ([83.29.107.35]:54835 "EHLO
	thinkpaddie") by vger.kernel.org with ESMTP id S261251AbVAWIKm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 03:10:42 -0500
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Organization: K4
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: can't compile 2.6.11-rc2 on sparc64
Date: Sun, 23 Jan 2005 09:09:16 +0100
User-Agent: KMail/1.7.91
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200501230238.55584@gj-laptop> <200501230248.27332@gj-laptop> <41F30848.6050408@osdl.org>
In-Reply-To: <41F30848.6050408@osdl.org>
X-Face: ?m}EMc-C]"l7<^`)a1NYO-(=?utf-8?q?=27xy3=3A5V=7B82Z=5E-/D3=5E=5BMU8IHkf=24o=60=7E=25CC5D4=5BGhaIgk?=
 =?utf-8?q?/=24oN7=0A=09Y7=3Bf=7D!?=(<IG>ooAGiKCVs$m~P1B-8Vt=]<V,FX{h4@fK/?Qtg]5ofD|P~&)q:6H>
 =?utf-8?q?=7E1Nt2fh=0A=09s-iKbN=24=2ENe=5E1?=(4tdwmmW>ew'=LPv+{{=YE=LoZU-5kfYnZSa`P7Q4pW]tKmUk`@&}M,
 =?utf-8?q?dn-=0A=09Kh=7BhA=7B=7ELs4a=24NjJI?=@1_f')]3|_}!GoJZss[Q$D-#l^.4GxPp[p:s<S~B&+6)
gj-laptop: yes
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501230909.17148@gj-laptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 January 2005 03:13, Randy.Dunlap wrote:

> It's the '-Werror' option that makes warnings become fatal
> errors that is stopping you here.  You could edit
> arch/sparc64/kernel/Makefile and remove/comment that for now.

Thanks, I didn't noticed that.
Have built only x86_74 and i386 archs before, these don't use -Wall I guess. 
(too many warnings on different signess comparation, btw, IMO security 
problem - might be in the future).

-- 
GJ
