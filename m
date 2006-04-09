Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWDIOpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWDIOpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 10:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWDIOpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 10:45:40 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:9616 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1750754AbWDIOpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 10:45:39 -0400
Date: Sun, 9 Apr 2006 17:45:35 +0300
From: Ville Herva <vherva@vianova.fi>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org,
       davem@davemloft.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
Message-ID: <20060409144534.GN29797@vianova.fi>
Reply-To: vherva@vianova.fi
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <20060408200915.GN1686@vianova.fi> <44388908.6070602@trash.net> <20060409074313.GZ15954@vianova.fi> <20060409144416.GO1686@vianova.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060409144416.GO1686@vianova.fi>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 05:44:16PM +0300, you [Ville Herva] wrote:
> I just realized 
> # CONFIG_NETFILTER_XT_MATCH_STATE is not set
> should probably be set. I'm building a new kernel now...

Ok, that seems to do it.

Thanks for the help, and sorry for the noise. I hope not too many people hit
the same glitch while upgrading...


-- v -- 

v@iki.fi

