Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTIYLin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbTIYLin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:38:43 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:61710 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261807AbTIYLil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:38:41 -0400
Date: Thu, 25 Sep 2003 12:38:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Armin Schindler <armin@melware.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.6 eicon/ and hardware/eicon/ drivers using the same symbols
Message-ID: <20030925123831.A10840@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Armin Schindler <armin@melware.de>, Adrian Bunk <bunk@fs.tum.de>,
	isdn4linux@listserv.isdn4linux.de,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20030925101541.GH15696@fs.tum.de> <Pine.LNX.4.31.0309251331150.21651-100000@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.31.0309251331150.21651-100000@phoenix.one.melware.de>; from armin@melware.de on Thu, Sep 25, 2003 at 01:33:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:33:53PM +0200, Armin Schindler wrote:
> The legacy eicon driver in drivers/isdn/eicon is the old one and will be
> removed as soon as all features went to the new driver.
> Anyway this old driver was never meant to be non-module.

What about just killing it off?  If users really want the old one
on 2.6 you can put up a tarball for them somewhere.

The driver is so horrinly ugly that it better goes away sooner than
later..

