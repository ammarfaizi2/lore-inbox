Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbTA0R0q>; Mon, 27 Jan 2003 12:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbTA0R0q>; Mon, 27 Jan 2003 12:26:46 -0500
Received: from k100-145.bas1.dbn.dublin.eircom.net ([159.134.100.145]:1811
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S267245AbTA0R0p>; Mon, 27 Jan 2003 12:26:45 -0500
Message-ID: <3E356D37.2000304@Linux.ie>
Date: Mon, 27 Jan 2003 17:32:39 +0000
From: Padraig@Linux.ie
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Steve Kenton <skenton@ou.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [FYI} The cygwin tool chain can *almost* build a 2.5.59 kernel
References: <3E356598.EF799135@ou.edu> <20030127171308.GA24651@work.bitmover.com>
In-Reply-To: <20030127171308.GA24651@work.bitmover.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> Last I checked the kernel has file name conflicts, i.e., "README" and
> "Readme" in the same directory in a windoze based file system.  You may
> not notice it if you get your kernel with tar but if you get it with BK
> then BK will detect that and tell you about it.   I don't remember which
> files conflict but I know there are about 12 of them in the 2.5 kernel.

The findsn component of http://www.pixelbeat.org/fslint/
shows the following (24 files) for 2.5.59:

include/linux/netfilter_ipv4/ipt_dscp.h
include/linux/netfilter_ipv4/ipt_DSCP.h
include/linux/netfilter_ipv4/ipt_ecn.h
include/linux/netfilter_ipv4/ipt_ECN.h
include/linux/netfilter_ipv4/ipt_mark.h
include/linux/netfilter_ipv4/ipt_MARK.h
include/linux/netfilter_ipv4/ipt_tcpmss.h
include/linux/netfilter_ipv4/ipt_TCPMSS.h
include/linux/netfilter_ipv4/ipt_tos.h
include/linux/netfilter_ipv4/ipt_TOS.h
include/linux/netfilter_ipv6/ip6t_mark.h
include/linux/netfilter_ipv6/ip6t_MARK.h
net/ipv4/netfilter/ipt_dscp.c
net/ipv4/netfilter/ipt_DSCP.c
net/ipv4/netfilter/ipt_ecn.c
net/ipv4/netfilter/ipt_ECN.c
net/ipv4/netfilter/ipt_mark.c
net/ipv4/netfilter/ipt_MARK.c
net/ipv4/netfilter/ipt_tcpmss.c
net/ipv4/netfilter/ipt_TCPMSS.c
net/ipv4/netfilter/ipt_tos.c
net/ipv4/netfilter/ipt_TOS.c
net/ipv6/netfilter/ip6t_mark.c
net/ipv6/netfilter/ip6t_MARK.c

Pádraig.

