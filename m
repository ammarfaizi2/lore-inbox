Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbTDAWkG>; Tue, 1 Apr 2003 17:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbTDAWkG>; Tue, 1 Apr 2003 17:40:06 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:33211 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S262906AbTDAWkC>;
	Tue, 1 Apr 2003 17:40:02 -0500
Subject: Re: netfilter/iptables bug ?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030401224446.GA4349@werewolf.able.es>
References: <20030401224446.GA4349@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049237482.25150.4.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Apr 2003 00:51:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 00:44, J.A. Magallon wrote:
> Hi all...
> 
> I'm trying to do NAT from a internal eth1 to external eth0 (connected
> with a cable modem). Every doc I read says I should do:
> 
> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
> 
> But I just keep getting:
> 
> iptables: Invalid argument
> 
> Kernel: 2.4.21-pre6 + -pre5-aa. iptables 1.2.7a.

Recompile iptables against your new kernel.
A major NAT patch (newnat) went into 2.4.20 which changed a lot of
structures. A recompile against a >= 2.4.20 kernel will get it working
again.

I suggest that you post further mail about iptables-problems to
netfilter@lists.netfilter.org as that's where you are most likely to get
help.

-- 
/Martin
