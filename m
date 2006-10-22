Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWJVWfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWJVWfc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWJVWfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:35:32 -0400
Received: from cantor.suse.de ([195.135.220.2]:29112 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750766AbWJVWfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:35:31 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: PAE broken on Thinkpad II
Date: Mon, 23 Oct 2006 00:35:25 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <1161472697.5528.6.camel@localhost.localdomain> <1161554591.5918.9.camel@localhost.localdomain> <200610230019.13801.ak@suse.de>
In-Reply-To: <200610230019.13801.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610230035.25860.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 00:19, Andi Kleen wrote:
> 
> > 
> > Unfortunately not. :( I just get those two lines up at the top of the
> > screen.
> 
> Have to debug it the hard way then. Can you add lots of 
> early_printks to let's say setup_arch and then around the
> following calls in start_kernel and see how far it gets?

Or alternatively if some earlier kernel worked bisect it please

-Andi
