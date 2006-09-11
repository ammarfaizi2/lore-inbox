Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbWIKU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbWIKU1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 16:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWIKU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 16:27:12 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:8640 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965015AbWIKU1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 16:27:12 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: Suspend to ram with 2.6 kernels
Date: Mon, 11 Sep 2006 22:27:15 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Eric Sandall <eric@sandall.us>,
       LKML <linux-kernel@vger.kernel.org>
References: <44FF8586.8090800@sandall.us> <20060907193333.GI8793@ucw.cz> <450536D0.4020705@domdv.de>
In-Reply-To: <450536D0.4020705@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609112227.15572.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 September 2006 12:13, Andreas Steinmetz wrote:
> Pavel Machek wrote:
> > See suspend.sf.net, use provided s2ram program.
> 
> Which,in my case (Acer Ferrari 4006), only works with "noapic" and
> "radeon" not loaded.
> Without "noapic" the system doesn't resume at all (same symptoms),

Have you tried with ec_intr=0?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
