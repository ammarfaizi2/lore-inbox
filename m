Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVAYLf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVAYLf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 06:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVAYLfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 06:35:32 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:52872 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261899AbVAYLcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 06:32:08 -0500
Date: Tue, 25 Jan 2005 12:31:59 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: kernel BUG at fs/sysfs/symlink.c:87
Message-ID: <20050125113159.GG29797@wohnheim.fh-wedel.de>
References: <20050124155100.GA2583@paradigm.rfc822.org> <20050124170445.GB4556@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050124170445.GB4556@paradigm.rfc822.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 January 2005 18:04:45 +0100, Florian Lohoff wrote:
> On Mon, Jan 24, 2005 at 04:51:00PM +0100, Florian Lohoff wrote:
> > Hi,
> > while using the bridging code between a tap0 and a real eth1 i got this:
> > 
> > Linux zmgr1.wstk.mediaways.net 2.6.10-zmgr-p3cel #1 Mon Jan 24 16:15:39 CET 2005 i686 GNU/Linux
> > 
> > UP, P3 Celeron, Non-Preempt, Vanilla Kernel
> 
> brctl addbr br0
> brctl addif br0 tap0
> brctl addif br0 eth0
> ifconfig br0 up
> 
> Oops
> 
> In this order it works
> 
> brctl addbr br0
> ifconfig br0 up
> brctl addif br0 tap0
> brctl addif br0 eth0

Doesn't look too complicated, but I'm not familiar enough with the
bridge code.  Setting Stephen on CC:, he should know a lot better.

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon
