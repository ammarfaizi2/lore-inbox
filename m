Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275274AbTHSBGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275271AbTHSBGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:06:05 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:23169 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275268AbTHSBF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:05:58 -0400
Date: Tue, 19 Aug 2003 02:05:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Valdis.Kletnieks@vt.edu, kernel@theoesters.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] Ratelimit SO_BSDCOMPAT warnings
Message-ID: <20030819010550.GF11081@mail.jlokier.co.uk>
References: <20030818150605.A23957@ns1.theoesters.com> <200308182215.h7IMFecc013449@turing-police.cc.vt.edu> <20030818154800.21ae818e.davem@redhat.com> <20030819003633.GC11081@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819003633.GC11081@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> David S. Miller wrote:
> > I see no reason to apply this, just fix your apps and the
> > warning will stop.  There's only a handful of programs
> > that trigger this at all.
> 
> Unfortunately Red Hat's BIND is among the more prominent. :-/

Sorry, I didn't mean to imply _just_ Red Hat.  Probably all distros'
BINDs use SO_BSDCOMPAT.  What I meant was this is the only program I
notice the warning from, when running a 2.5 kernel on an otherwise Red
Hat 9 system.  And it comes up every time I connect to the net, when I
restart named with new forwarders, which is about hourly :/

-- Jamie

