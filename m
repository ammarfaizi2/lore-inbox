Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274859AbTHSRKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273015AbTHSRIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:08:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16011 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272311AbTHSREI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:04:08 -0400
Date: Tue, 19 Aug 2003 09:56:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819095611.0fb8f9a3.davem@redhat.com>
In-Reply-To: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>
References: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 13:02:20 +0100
Richard Underwood <richard@aspectgroup.co.uk> wrote:

> David S. Miller wrote:
> > Under Linux, by default, IP addresses are owned by the system
> > not by interfaces.  This increases the likelyhood of successful
> > communication on a subnet.
> > 
> 	This is crap.

Nope, the RFCs allow this.

So this is where we must agree to disagree.  Because host ownership of
IP addresses is the basis for all of the arguments and it completely
justifies Linux's ARP behavior on both sides.
