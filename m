Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbTDAWm3>; Tue, 1 Apr 2003 17:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbTDAWm3>; Tue, 1 Apr 2003 17:42:29 -0500
Received: from jalon.able.es ([212.97.163.2]:8951 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262914AbTDAWm1>;
	Tue, 1 Apr 2003 17:42:27 -0500
Date: Wed, 2 Apr 2003 00:53:44 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: netfilter/iptables bug ?
Message-ID: <20030401225344.GA4397@werewolf.able.es>
References: <20030401224446.GA4349@werewolf.able.es> <1049237482.25150.4.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1049237482.25150.4.camel@tux.rsn.bth.se>; from gandalf@wlug.westbo.se on Wed, Apr 02, 2003 at 00:51:22 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.02, Martin Josefsson wrote:
> On Wed, 2003-04-02 at 00:44, J.A. Magallon wrote:
> > Hi all...
> > 
> > I'm trying to do NAT from a internal eth1 to external eth0 (connected
> > with a cable modem). Every doc I read says I should do:
> > 
> > iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> > 
> > But I just keep getting:
> > 
> > iptables: Invalid argument
> > 
> > Kernel: 2.4.21-pre6 + -pre5-aa. iptables 1.2.7a.
> 
> Recompile iptables against your new kernel.
> A major NAT patch (newnat) went into 2.4.20 which changed a lot of
> structures. A recompile against a >= 2.4.20 kernel will get it working
> again.
> 
> I suggest that you post further mail about iptables-problems to
> netfilter@lists.netfilter.org as that's where you are most likely to get
> help.
> 

Thankyou very much.

Sometimes I doubt if this is a maling list or an IRC channel ;))


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
