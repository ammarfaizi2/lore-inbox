Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUFBS3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUFBS3H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUFBS3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:29:07 -0400
Received: from outmx009.isp.belgacom.be ([195.238.3.4]:15266 "EHLO
	outmx009.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262766AbUFBS3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:29:04 -0400
Subject: Re: why swap at all?
From: FabF <fabian.frederick@skynet.be>
To: Valdis.Kletnieks@vt.edu
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200406021759.i52Hx00N022255@turing-police.cc.vt.edu>
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net>
	 <1086154721.2275.2.camel@localhost.localdomain>
	 <200406021759.i52Hx00N022255@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1086201031.2047.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 02 Jun 2004 20:30:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 19:59, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 02 Jun 2004 07:38:41 +0200, FabF said:
> 
> > > Yes but: your wm is so  often used/activated it will not get swaped  out. 
> > > But if your mouse passes over mozilla and tries to focus it, then you will
> > > feel the pain of a swapped-out x program.
> > > 
> > Exactly !
> > Does autoregulated VM swap. patch could help here ?
> 
> Con's auto-adjusting swappiness patch did in fact help that quite a bit,
> especially for the case of heavy file I/O causing process images to be swapped
> out.  I need to do some comparisons of that to Nick's MM work...
It helps inactive applications to re-ermerge smoothly, heavy I/O and
global tuning.I've got 20 swapping delta from start to high usage.
That patch rock'n'roll my box until updatedb makes sw climbs up to 80
and freezes my box :(

FabF

