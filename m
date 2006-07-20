Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWGTR3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWGTR3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWGTR3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:29:05 -0400
Received: from outmx007.isp.belgacom.be ([195.238.5.234]:28380 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750805AbWGTR3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:29:04 -0400
Subject: Re: [PATCH] sound: Conversions from kmalloc+memset to k(z|c)alloc.
From: Panagiotis Issaris <takis@gna.org>
To: Pete Zaitcev <zaitcev@yahoo.com>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
       twoller@crystal.cirrus.com, James@superbug.demon.co.uk, zab@zabbo.net,
       sailer@ife.ee.ethz.ch, perex@suse.cz
In-Reply-To: <20060719024819.25960.qmail@web60412.mail.yahoo.com>
References: <20060719024819.25960.qmail@web60412.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 19:28:46 +0200
Message-Id: <1153416526.11873.26.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On di, 2006-07-18 at 19:48 -0700, Pete Zaitcev wrote:
> --- Panagiotis Issaris <takis@lumumba.uhasselt.be> wrote:
> 
> > sound: Conversions from kmalloc+memset to k(c|z)alloc.
> > 
> > Signed-off-by: Panagiotis Issaris <takis@issaris.org>
> 
> >  sound/oss/ymfpci.c              |    6 ++----
> 
> I can't fathom why you would want to bother. These drivers are going to
> be removed from tree anyway. 
For the fun of it :) And, well, OSS has been deprecated for a long time,
but as it is still in the tree I figured cleaning it up would still be
useful for the time being.

Cheers,
Takis

