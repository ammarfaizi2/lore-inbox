Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVJCAyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVJCAyM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 20:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVJCAyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 20:54:12 -0400
Received: from free.hands.com ([83.142.228.128]:57286 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932099AbVJCAyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 20:54:12 -0400
Date: Mon, 3 Oct 2005 01:54:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003005400.GM6290@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 04:37:52PM -0700, Vadim Lobanov wrote:

> >  what if, therefore, someone comes up with an architecture that is
> >  better than or improves greatly upon SMP?
> 
> Like NUMA?
 
 yes, like numa, and there is more.

 i had the honour to work with someone who came up with a radical
 enhancement even to _that_.

 basically the company has implemented, in hardware (a
 nanokernel), some operating system primitives, such as message
 passing (based on a derivative by thompson of the "alice"
 project from plessey, imperial and manchester university
 in the mid-80s), hardware cache line lookups (which means
 instead of linked list searching, the hardware does it for
 you in a single cycle), stuff like that.

 the message passing system is designed as a parallel message bus -
 completely separate from the SMP and NUMA memory architecture, and as
 such it is perfect for use in microkernel OSes.

 (these sorts of things are unlikely to make it into the linux kernel, no
 matter how much persuasion and how many patches they would write).

 _however_, a much _better_ target would be to create an L4 microkernel
 on top of their hardware kernel.

 this company's hardware is kinda a bit difficult for most people to get
 their heads round: it's basically parallelised hardware-acceleration for
 operating systems, and very few people see the point in that.

 however, as i pointed out, 90nm and approx-2Ghz is pretty much _it_,
 and to get any faster you _have_ to go parallel.

 and the drive for "faster", "better", "more sales" means more and more
 parallelism.

 it's _happening_ - and SMP ain't gonna cut it (which is why
 these multi-core chips are coming out and why hyperthreading
 is coming out).

 so.

 this is a heads-up.

 what you choose to do with this analysis is up to you.

 l.

