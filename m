Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266227AbUHBDBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUHBDBV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 23:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUHBDBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 23:01:21 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:18450 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266227AbUHBDBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 23:01:19 -0400
Date: Mon, 2 Aug 2004 11:13:39 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
cc: Daniel Phillips <phillips@istop.com>,
       "Walker, Bruce J" <bruce.walker@hp.com>,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       opengfs-devel@lists.sourceforge.net,
       opengfs-users@lists.sourceforge.net,
       opendlm-devel@lists.sourceforge.net
Subject: Re: [Linux-cluster] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
In-Reply-To: <410D2949.20503@backtobasicsmgmt.com>
Message-ID: <Pine.LNX.4.58.0408021112170.18701@wombat.indigo.net.au>
References: <3689AF909D816446BA505D21F1461AE4C750E6@cacexc04.americas.cpqcorp.net>
 <200408011330.01848.phillips@istop.com> <410D2949.20503@backtobasicsmgmt.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004, Kevin P. Fleming wrote:

> Daniel Phillips wrote:
> 
> > On Saturday 31 July 2004 12:00, Walker, Bruce J wrote:
> > 
> >>In the 2.4 implementation, providing this one capability by
> >>leveraging devfs was quite economic, efficient and has been very stable.
> > 
> > 
> > I wonder if device-mapper (slightly hacked) wouldn't be a better approach for 
> > 2.6+.
> 
> It appeared from the original posting that their "cluster-wide devfs" 
> actually supported all types of device nodes, not just block devices. I 
> don't know whether accessing a character device on another node would 
> ever be useful, but certainly using device-mapper wouldn't help for that 
> case.

Does the reduced function 2.6 devfs still have what's needed?
If it does then you should have a fair amount of breathing space.


