Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272747AbTHSRxZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 13:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272602AbTHSRvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 13:51:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62091 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270772AbTHSRn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 13:43:58 -0400
Date: Tue, 19 Aug 2003 10:36:13 -0700
From: "David S. Miller" <davem@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: bloemsaa@xs4all.nl, richard@aspectgroup.co.uk, skraw@ithnet.com,
       willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819103613.4485e549.davem@redhat.com>
In-Reply-To: <20030819173920.GA3301@marowsky-bree.de>
References: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>
	<070c01c36653$7f3c1ab0$c801a8c0@llewella>
	<20030819083438.26c985b9.davem@redhat.com>
	<20030819173920.GA3301@marowsky-bree.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 19:39:20 +0200
Lars Marowsky-Bree <lmb@suse.de> wrote:

> On 2003-08-19T08:34:38,
>    "David S. Miller" <davem@redhat.com> said:
> 
> > There are two valid ways the RFCs allow systems to handle
> > IP addresses.
> > 
> > 1) IP addresses are owned by "the host"
> > 2) IP addresses are owned by "the interface"
> > 
> > Linux does #1, many systems do #2, both are correct.
> 
> Yes, both are "correct" in the sense that the RFC allows this
> interpretation. The _sensible_ interpretation for practical networking
> however is #2, and the only persons who seem to believe differently are
> those in charge of the Linux network code...

And, as Alan said, we provide a way for one to obtain your networking
religion of week.

Changing the default is not an option, that would undoubtedly
break things.
