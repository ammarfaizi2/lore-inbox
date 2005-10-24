Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVJXHxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVJXHxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 03:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVJXHxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 03:53:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58544 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750734AbVJXHxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 03:53:11 -0400
Date: Mon, 24 Oct 2005 00:52:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pj@sgi.com, damir.perisa@solnet.ch, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 - drivers/serial/jsm/jsm_tty.c: no member named
 'flip'
Message-Id: <20051024005213.5bc82015.akpm@osdl.org>
In-Reply-To: <1129974887.15961.1.camel@localhost.localdomain>
References: <20051016154108.25735ee3.akpm@osdl.org>
	<200510171229.57785.damir.perisa@solnet.ch>
	<1129572346.2424.8.camel@localhost>
	<20051021190839.2f94f2a2.pj@sgi.com>
	<20051021233915.5ff50f9f.akpm@osdl.org>
	<1129974887.15961.1.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Gwe, 2005-10-21 at 23:39 -0700, Andrew Morton wrote:
> > If it helps, sure.  It looks like those patches will be -mm-only for a
> > while yet.  I haven't actually sat down and worked out how many drivers are
> > still broken, nor how important they are, but the amount of breakage does
> > still appear to be considerable.
> 
> The only broken driver I am aware of remaining is the jsm driver, and
> possibly one or two embedded drivers that the authors simply won't fix
> until it goes mainstream.
> 
> ISDN was the last big one and I sent fixes for that.
> 
> What else is broken ?
> 

Hard to quantify, really.  One would need to iteratively disable config
options to generate a complete list.  Perhaps a `make -i' will tell?

drivers/serial/sunsab.c is one.

