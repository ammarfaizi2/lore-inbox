Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271666AbTGRBOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 21:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271670AbTGRBOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 21:14:16 -0400
Received: from dp.samba.org ([66.70.73.150]:40682 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271666AbTGRBOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 21:14:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [2.4 patch] netfilter Configure.help cleanup 
In-reply-to: Your message of "Thu, 17 Jul 2003 22:13:05 +0200."
             <20030717201304.GL1407@fs.tum.de> 
Date: Fri, 18 Jul 2003 11:06:49 +1000
Message-Id: <20030718012910.0D5BB2C5A9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030717201304.GL1407@fs.tum.de> you write:
> On Wed, Jul 02, 2003 at 04:25:05PM -0300, Marcelo Tosatti wrote:
> > 
> > Make that go through davem, please.
> 
> Hi Dave,
> 
> the patch below does the following changes to the netfilter entries in
> Configure.help in 2.4.22-pre2:
> - order similar to net/ipv4/netfilter/Config.in
> - remove useless short descriptions above CONFIG_*
> - added CONFIG_IP_NF_MATCH_RECENT entry (stolen from 2.5)

Sorry Adrian, I think this is overzealous.

Please just add the CONFIG_IP_NF_MATCH_RECENT entry.  Remember,
"stable" means "boring". 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
