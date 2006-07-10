Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWGJNGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWGJNGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWGJNGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:06:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13024 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161026AbWGJNGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:06:33 -0400
Subject: Re: [RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with
	-Wshadow
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000607100603r7ac59457tc1b080a15ed84db3@mail.gmail.com>
References: <9a8748490607100548o14dbe684j40bde90eb19a7558@mail.gmail.com>
	 <1152535999.4874.36.camel@laptopd505.fenrus.org>
	 <d120d5000607100603r7ac59457tc1b080a15ed84db3@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 15:06:31 +0200
Message-Id: <1152536791.4874.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 09:03 -0400, Dmitry Torokhov wrote:
> On 7/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > > So, what do people say?
> >
> >
> > Hi,
> >
> > I'm just about always in favor of having automated tools help us find
> > bugs. However... can you give an indication of how many real bugs you
> > have encountered? If it's "mostly noise" all the time.. then it's maybe
> > not worth the effort... while if you find real bugs then it's obviously
> > worthwhile to go through this.
> >
> 
> While we may not have any issues with the present code it can help
> avoiding problems in new code if we have -Wshadow by default.

I agree with that; however that still depends on the ratio of real bugs
vs "noise". While it's hard to estimate for future code, the existing
code base can be an indication...


