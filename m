Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270751AbTHSPpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270801AbTHSPpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:45:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62857 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270759AbTHSPpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:45:12 -0400
Date: Tue, 19 Aug 2003 08:34:38 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
Cc: richard@aspectgroup.co.uk, skraw@ithnet.com, willy@w.ods.org,
       alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819083438.26c985b9.davem@redhat.com>
In-Reply-To: <070c01c36653$7f3c1ab0$c801a8c0@llewella>
References: <353568DCBAE06148B70767C1B1A93E625EAB57@post.pc.aspectgroup.co.uk>
	<070c01c36653$7f3c1ab0$c801a8c0@llewella>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 15:11:59 +0200
"Bas Bloemsaat" <bloemsaa@xs4all.nl> wrote:

> It it doesn't define a standard either, but makes
> perfectly clear that any interface has it's own ARP,
> not one ARP for the entire system.

This is absolutely not true.

There are two valid ways the RFCs allow systems to handle
IP addresses.

1) IP addresses are owned by "the host"
2) IP addresses are owned by "the interface"

Linux does #1, many systems do #2, both are correct.

We provide ways for you to obtain the behavior or #2
so there is nothing to complain about.

