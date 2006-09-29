Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWI2Mkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWI2Mkt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 08:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWI2Mkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 08:40:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50638 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964871AbWI2Mkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:40:49 -0400
Subject: Re: [BUG] ? Strange behaviour since kernel 2.6.17 with a https
	website
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tchesmeli Serge <serge@lea-linux.com>
Cc: Joerg Roedel <joro-lkml@zlug.org>, linux-kernel@vger.kernel.org
In-Reply-To: <451CF08D.8030606@lea-linux.com>
References: <451CEBA8.8050604@lea-linux.com>
	 <20060929100211.GB19115@zlug.org>  <451CF08D.8030606@lea-linux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 14:05:54 +0100
Message-Id: <1159535154.13029.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-29 am 12:08 +0200, ysgrifennodd Tchesmeli Serge:
> Joerg Roedel wrote:
> > On Fri, Sep 29, 2006 at 11:47:20AM +0200, Tchesmeli Serge wrote:
> >
> >   
> >> Me and a friend have discover a stange behaviour since kernel 2.6.17.
> >>     
> >
> > Please try to switch off TCP window scaling using the command below
> > (as root) and retry.
> >
> > echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
> >
> >   
> Yes, it's work!

That means your bank or someone before it probably has a broken
firewall. I would worry about that given how long ago (and thus how many
firmware updates ago) almost every vendor fixed problems like this with
their products.

Alan
