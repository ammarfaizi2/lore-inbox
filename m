Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbTDDSCh (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTDDSCg (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:02:36 -0500
Received: from havoc.daloft.com ([64.213.145.173]:23425 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263803AbTDDSCf (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:02:35 -0500
Date: Fri, 4 Apr 2003 13:14:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Abhishek Agrawal <abhishek@abhishek.agrawal.name>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange e1000
Message-ID: <20030404181400.GA26545@gtf.org>
References: <043501c2faaf$da061e10$3f00a8c0@witbe> <1049465969.3324.40.camel@abhilinux.cygnet.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049465969.3324.40.camel@abhilinux.cygnet.co.in>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 07:49:28PM +0530, Abhishek Agrawal wrote:
> On Fri, 2003-04-04 at 19:11, Paul Rolland wrote:
> 
> > Could it be possible that the 1000MBps FD on the e1000 side is
> > a local configuration, and that it needs some time to discuss with
> > the Netgear switch to negotiate correctly speed and duplex before
> > working correctly ? (i.e. 20 sec = negotiation time)
> Autoneg must be completed within 2 sec, or else it is considered as
> failed.

If we follow this rule, we have lots of Cisco and other network gear
that will not be able to communicate with Linux.

	Jeff



