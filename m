Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUITUjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUITUjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267346AbUITUjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:39:44 -0400
Received: from mail.dif.dk ([193.138.115.101]:62876 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267341AbUITUjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:39:42 -0400
Date: Mon, 20 Sep 2004 22:46:25 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc2 (compile stats)
In-Reply-To: <MPG.1bb95958863740f59896f3@news.gmane.org>
Message-ID: <Pine.LNX.4.61.0409202244370.2729@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
 <1095700064.2867.30.camel@cherrybomb.pdx.osdl.net> <MPG.1bb95958863740f59896f3@news.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004, Giuseppe Bilotta wrote:

> Linus Torvalds wrote:
> > > The one thing that people may actually _notice_ is that you get a lot more 
> > > warnings for some drivers due to the stricter type-checks for PCI memory 
> > > mapping. They are harmless (code generation should be the same), and we'll 
> > > work on trying to fix up the drivers as we go along, but they can be a bit 
> > > daunting if you happen to enable some of the less type-friendly drivers 
> > > right now..
> 
> John Cherry wrote:
> > Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
> >              (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
> > -----------  -----------  -------- -------- -------- -------- ---------
> > 2.6.9-rc2      0w/0e       0w/0e  3036w/0e   41w/0e  11w/0e   3655w/0e
> > 2.6.9-rc1      0w/0e       0w/0e    77w/10e   4w/0e   3w/0e     68w/0e
> 
> Jeepers! Talk about 'daunting' ... :)
> 
Yup, janitors like myself just got a whole bunch of work thrown our way...

Btw, please don't trim CC lists on linux-kernel.


--
Jesper Juhl

