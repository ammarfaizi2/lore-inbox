Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTKUFSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 00:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTKUFSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 00:18:54 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:21494 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264300AbTKUFSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 00:18:53 -0500
Date: Fri, 21 Nov 2003 00:18:38 -0500
From: Bill Nottingham <notting@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] All my Pcmcia cards are 'eth0'
Message-ID: <20031121051838.GA13127@devserv.devel.redhat.com>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <Ua09.2Wt.17@gated-at.bofh.it> <Uajn.3lb.7@gated-at.bofh.it> <m34qwy5mm7.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34qwy5mm7.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (ak@muc.de) said: 
> > There are some situations where you have to jump through hoops
> > because it can't atomically swap two device names (i.e.,
> > eth0 <-> eth1, but the code itself seems to work ok in use here...
> 
> Adding such swapping should not be very hard if someone is motivated.
> Interestingly you're the first to complain about it missing...

When I looked at it, I assumed it was a limitation of the
kernel interface, in that it only operated on one device at
a time... or are you talking about just doing the switch in
nameif itself with a temporary device name?

Bill
