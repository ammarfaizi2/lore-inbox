Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTFGT7p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTFGT7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:59:45 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:4552 "EHLO
	michonline.com") by vger.kernel.org with ESMTP id S263458AbTFGT7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:59:44 -0400
Date: Sat, 7 Jun 2003 16:18:48 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Andi Kleen <ak@muc.de>
Cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@wide.ad.jp>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, vojtech@suse.cz
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on CONFIG_EMBEDDED
Message-ID: <20030607201848.GE20872@michonline.com>
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@wide.ad.jp>,
	linux-kernel@vger.kernel.org, akpm@digeo.com, vojtech@suse.cz
References: <20030607063424.GA12616@averell> <20030607.154958.108408804.yoshfuji@wide.ad.jp> <20030607184018.GA3473@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607184018.GA3473@averell>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 08:40:18PM +0200, Andi Kleen wrote:
> On Sat, Jun 07, 2003 at 03:49:58PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> > Why isn't it enough to change default to "y"?
> 
> Because that won't override make oldconfig
> 
> > Not showing the config is not good.
> > I want to disable it while using standard (not embeded) PC.
> 
> You can still. That is what CONFIG_EMBEDDED is for.

Thinking about this, would a CONFIG_DWIM type setting make sense?
Something to drive "least surprise" settings from, without tying it to
any other functionality?

(For the acronym impaired, DWIM = Do What I Mean[t])

-- 

Ryan Anderson
  sometimes Pug Majere
