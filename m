Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbUD2OYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUD2OYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUD2OYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:24:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8114 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262273AbUD2OYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:24:18 -0400
Date: Thu, 29 Apr 2004 11:25:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: wichert@wiggy.net
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429142528.GH18474@logos.cnet>
References: <20040428180038.73a38683.akpm@osdl.org> <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com> <20040428185720.07a3da4d.akpm@osdl.org> <20040429022944.GA24000@buici.com> <20040428193541.1e2cf489.akpm@osdl.org> <20040429031059.GA26060@buici.com> <20040429080219.GF4437@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429080219.GF4437@wiggy.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 10:02:19AM +0200, Wichert Akkerman wrote:
> Previously Marc Singer wrote:
> > I'm thinking that the problem is that the page cache is greedier that
> > most people expect.  For example, if I could hold the page cache to be
> > under a specific size, then I could do some performance measurements.
> 
> It is actually greedy enough that when my nightly cron starts I suddenly
> see apache and pdns_recursor being killed consistently every day. 

Which kernel is that? 

They are getting killed because there is no more swap available.
Otherwise its a bug.

