Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270338AbTG1Qyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 12:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270345AbTG1Qyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 12:54:46 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:29593
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id S270338AbTG1Qyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 12:54:44 -0400
Date: Mon, 28 Jul 2003 10:09:59 -0700
From: Phil Oester <kernel@theoesters.com>
To: Carlos Velasco <carlosev@newipnet.com>
Cc: "David S. Miller" <davem@redhat.com>, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030728100959.A13335@ns1.theoesters.com>
References: <20030727165831.05904792.davem@redhat.com> <200307280211590888.10957DD9@192.168.128.16> <20030727171403.6e5bcc58.davem@redhat.com> <200307280235210263.10AADFF8@192.168.128.16> <20030727173600.475d95fb.davem@redhat.com> <200307280253090799.10BB2DF0@192.168.128.16> <20030727175557.1d624b36.davem@redhat.com> <200307280323020667.10D68954@192.168.128.16> <20030727183547.784b6ab5.davem@redhat.com> <200307281243530385.12D80171@192.168.128.16>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307281243530385.12D80171@192.168.128.16>; from carlosev@newipnet.com on Mon, Jul 28, 2003 at 12:43:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What I think David fails to realize is that in the real world, people
use the hidden patch on a regular basis.  It is the simplest way to
achieve what we want to in a server farm consisting of hundreds of
servers.  It also involves the least overhead.  

And NO - I do not use IPVS.  I use one of the many hardware based
loadbalancers which work flawlessly with the hidden flag.

Those in ivory towers can pontificate endlessly about how one 'should'
fix the arp problem.  Those in the trenches will do it the easy way.

Phil Oester

> On 27/07/2003 at 18:35 David S. Miller wrote:
> 
> >I don't deny that it fixes your problem, that is not what
> >we're talking about.  We're talking about how one should
> >fix the problem, and I'm trying to show you why "hidden"
> >patch is not the answer to that.
