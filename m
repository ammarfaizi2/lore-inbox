Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWBJWer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWBJWer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWBJWer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:34:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42434 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751129AbWBJWeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:34:46 -0500
Date: Fri, 10 Feb 2006 17:34:41 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jim Crilly <jim@why.dont.jablowme.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: 2.6.16-rc2-mm1
Message-ID: <20060210223441.GJ31949@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Jim Crilly <jim@why.dont.jablowme.net>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <20060207220627.345107c3.akpm@osdl.org> <20060210213058.GE11297@voodoo> <20060210142502.2fd320ff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210142502.2fd320ff.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 02:25:02PM -0800, Andrew Morton wrote:
 
 > > --- linux-2.6.16-rc2-mm1/drivers/net/tulip/media.c  2006-02-09 22:13:36.403653502 -0500
 > > +++ linux-2.6.16-rc2-mm1-new/drivers/net/tulip/media.c  2006-02-10 15:51:41.821983228 -0500
 > > @@ -399,8 +399,6 @@ void tulip_select_media(struct net_devic
 > > 
 > >   tp->csr6 = new_csr6 | (tp->csr6 & 0xfdff) | (tp->full_duplex ? 0x0200 : 0);
 > > 
 > > - mdelay(1);
 > > -
 > >   return;
 > >  }
 > 
 > It might not be.  And the knowledge of which cards this will bust and why
 > may be lost in the mists of time.

Tulip fixes for Cobalt Qube/RaQ

change 12755c16a9e4fa2fd5b0ca1963e83d671a6251da
on 2005-06-26 16 by Ralf Baechle <ralf@linux-mips.org> 

		Dave

