Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTLJXiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTLJXiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:38:21 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15326
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264119AbTLJXiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:38:19 -0500
Date: Thu, 11 Dec 2003 00:39:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>,
       Kendall Bennett <KendallB@scitechsoft.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210233959.GF11193@dualathlon.random>
References: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com> <3FD7081D.31093.61FCFA36@localhost> <20031210221800.GM6896@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210221800.GM6896@work.bitmover.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 02:18:00PM -0800, Larry McVoy wrote:
> interfaces, the EXPORT_GPL stuff, all of that as a way to delibrately

forget EXPORT_GPL, that's an hint, all _GPL can be removed, and any
EXPORT_SYMBOL can be added. what is a derived work or not, what is legal
or not, has nothing to do with whatever EXPORT_SYMBOL_GPL or even with
EXPORT_SYMBOL.

Clearly if we export everything with EXPORT_SYMBOL we make life easier
to illegal people, that's why using EXPORT_SYMBOL_GPL can make sense,
but any distributor is free to drop all _GPL tags everywhere, and export
every single kernel function with EXPORT_SYMBOL. If somebody than makes
a derived work through those exported symbols illegally, that's his own
problem. The distributor has no control on the export symbol users.

just look vmmon, that's a derived work with a non GPL compatible
licence, it does everything through exported symbols but it doesn't mean
it's not a derivative work.
