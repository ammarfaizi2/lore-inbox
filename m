Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTEOFLb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 01:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTEOFLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 01:11:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:32747 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261863AbTEOFL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 01:11:29 -0400
Date: Wed, 14 May 2003 22:20:41 -0700
From: Greg KH <greg@kroah.com>
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev
Message-ID: <20030515052041.GA5995@kroah.com>
References: <20030514205949.GA3945@kroah.com> <200305142221.h4EMLRGi009323@locutus.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305142221.h4EMLRGi009323@locutus.cmf.nrl.navy.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 06:21:27PM -0400, chas williams wrote:
> >Is this going to help us be able to get rid of the MOD_* calls in ATM
> >drivers soon?
> 
> no.  a later patch will get rid of those though.  next in the queue 
> will be to make atm itself modular and make vcc's do reference counting
> (via their struct sock parent).  i could fix the MOD_ nonsense next if
> its really bothering you.

It's not really bothering me, just wondering when it will go away (I see
it when building one of the USB ATM drivers...)

The V4L use of MOD_* is bothering me, as there are more USB V4L drivers
than USB ATM drivers :)

thanks,

greg k-h
