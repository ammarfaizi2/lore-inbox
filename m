Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285179AbRLFVJ5>; Thu, 6 Dec 2001 16:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLFVJs>; Thu, 6 Dec 2001 16:09:48 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:13836 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S284248AbRLFVJm>; Thu, 6 Dec 2001 16:09:42 -0500
Date: Thu, 6 Dec 2001 16:09:40 -0500
From: Lennert Buytenhek <buytenh@gnu.org>
To: netfilter@lists.samba.org, linux-kernel@vger.kernel.org
Cc: bridge@math.leidenuniv.nl
Subject: bridge firewalling with linux 2.4: it _is_ possible..
Message-ID: <20011206160940.A9972@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

People say my PR sucks, and it probably does.  I've been somewhat reluctant
to announce this, but people here at Linux Kongress convinced me that a lot
of people probably don't even know about this, so here goes.

For a while now I've had a patch that makes bridge firewalling with linux
2.4 possible.  This gives you all the goodies of the already present
netfilter/iptables infrastructure, including state tracking, various baroque
packet mangling techniques and network address translation (yeah, NAT on a
bridge, I know, you can call me sick, a lot of people do, hi Rusty).

Get the patch at:

(stable)
	http://bridge.sourceforge.net/devel/bridge-nf/bridge-nf-0.0.3-against-2.4.13-ac7.diff

(devel)
	http://bridge.sourceforge.net/devel/bridge-nf/bridge-nf-0.0.4-pre1-against-2.4.16.diff


The patch makes bridging look like routing, as far as netfilter is concerned,
so you can use your existing rulesets with minimal modification.  The patch
will be submitted for netfilter patch-o-matic sometime in the future, once
I clean it up some more (there are some known loose ends).


cheers,
Lennert

