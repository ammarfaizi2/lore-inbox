Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267712AbTGHVtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 17:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267730AbTGHVtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 17:49:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6574
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267712AbTGHVtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 17:49:31 -0400
Subject: Re: Forking shell bombs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Charles Cazabon <linux@discworld.dyndns.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030708125520.B27956@discworld.dyndns.org>
References: <20030708184537.GJ1030@dbz.icequake.net>
	 <20030708125520.B27956@discworld.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057701680.5572.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jul 2003 23:01:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-08 at 19:55, Charles Cazabon wrote:
> Ryan Underwood <nemesis-lists@icequake.net> wrote:
> > 
> > [Fork bomb] and watch linux die. (2.4.21 stock)
> 
> That's what per-user process limits are for.  Doesn't matter if it's a
> shellscript or something else; any system without limits set is vulnerable.

In general turning on vm overcommit protection on a -ac tree should
be sufficient - per user limits are better

