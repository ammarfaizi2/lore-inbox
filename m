Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbTDQO2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbTDQO2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:28:08 -0400
Received: from havoc.daloft.com ([64.213.145.173]:36238 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261474AbTDQO2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:28:07 -0400
Date: Thu, 17 Apr 2003 10:40:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
Message-ID: <20030417144003.GB18749@gtf.org>
References: <3E9DFC11.50800@pobox.com> <1050585430.31390.32.camel@dhcp22.swansea.linux.org.uk> <20030417143202.GA18749@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417143202.GA18749@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 10:32:02AM -0400, Jeff Garzik wrote:
> On Thu, Apr 17, 2003 at 02:17:16PM +0100, Alan Cox wrote:
> > isn't it best if so to use __builtin_memcpy without our existing
> > macros not just trust the compiler ?

> hum, I didn't parse this at all:
> Use of __builtin_memcpy implies trusting the compiler :)
> 
> Maybe you meant s/without/with/ ?

And further, if you did indeed mean s/without/with/ ...
that's -exactly- what my submitted patch did.

	Jeff



