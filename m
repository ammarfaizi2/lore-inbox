Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269073AbUHaT4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269073AbUHaT4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 15:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269064AbUHaTve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 15:51:34 -0400
Received: from mx-out.forthnet.gr ([193.92.150.6]:24693 "EHLO
	mx-out-01.forthnet.gr") by vger.kernel.org with ESMTP
	id S269074AbUHaTta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:49:30 -0400
From: V13 <v13@priest.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Root reservations for strict overcommit
Date: Tue, 31 Aug 2004 22:49:35 +0300
User-Agent: KMail/1.7
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040831143449.GA26680@devserv.devel.redhat.com> <ch2b68$985$1@gatekeeper.tmr.com> <1093970232.611.16.camel@localhost.localdomain>
In-Reply-To: <1093970232.611.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408312249.36218.v13@priest.com>
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 August 2004 19:37, Alan Cox wrote:
> On Maw, 2004-08-31 at 18:13, Bill Davidsen wrote:
> > Would it be a problem to put a lower bound on how much to leave for
> > root? If it's really too small to be useful, perhaps one of (a) reserve
> > enough to be useful or (b) don't bother to reserve at all, should be
>
> Possibly. I'm currently following what someone appears to have decided
> is correct behaviour. It probably should be tunable

I believe it makes more sense to describe it as KB instead of %. Noone should 
have to reserve 120MB for root on a 4G box. Even if it is tunable, memory 
size seems better than percent since you'll not have to change it when you 
add/remove memory from your box.

<<V13>>
