Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284766AbRLEWZS>; Wed, 5 Dec 2001 17:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284754AbRLEWZI>; Wed, 5 Dec 2001 17:25:08 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:57106 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S284760AbRLEWYz>; Wed, 5 Dec 2001 17:24:55 -0500
Date: Wed, 5 Dec 2001 15:03:15 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Romain Giry <romain_giry@yahoo.fr>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: transparent firewall??
Message-ID: <20011205150315.B2593@emma1.emma.line.org>
Mail-Followup-To: Romain Giry <romain_giry@yahoo.fr>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <5.0.2.1.0.20011205114948.01a65410@pop.mail.yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5.0.2.1.0.20011205114948.01a65410@pop.mail.yahoo.fr>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2001, Romain Giry wrote:

> I'd like to know if anyone has a transparent firewall that is one that 
> doesn't make any rules on the traffic but only always pass it without this 
> beeing notified by the rest of the network system... this should help me to 
> do my thesis. I would be like adding one transparent layer between the 
> network layer (ip) and the link layer (physical).

Semi-transparent: Proxy ARP, works at a site that I administer.

Really transparent: Check out bridge.sourceforge.net, that project -
among other goals - aims at making Linux 2.4's bridge code aware of
netfilter.

I'm not quite sure if some BSD variants can already do that (FreeBSD
maybe), check their sites as well.

Hope that helps.
Matthias


P. S.: the "To" address of your news-to-list gateway is
"mlist-linux-kernel", which breaks list detection and automatic list
replies in some mailers, notably mutt. Please include Mail-Followup-To:
headers or have the administrator of the news-to-mail gate fix their
configuration. Thanks a lot.
