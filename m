Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272503AbTHKLpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 07:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272508AbTHKLpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 07:45:40 -0400
Received: from lidskialf.net ([62.3.233.115]:60291 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S272503AbTHKLpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 07:45:39 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [BUG mm-tree of test2/test3] nforce2-acpi-fixes breaks via ide controller
Date: Mon, 11 Aug 2003 12:45:40 +0100
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Weber <shawk@gmx.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.SOL.4.30.0308111326150.11836-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0308111326150.11836-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308111245.40154.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 August 2003 12:28, Bartlomiej Zolnierkiewicz wrote:
> On Mon, 11 Aug 2003, Andrew de Quincey wrote:
> > > > I do not know why it should interfere with my via stuff, but it does.
> > > > A vanilla test3 kernel is working fine as well, whereas test3-mm1
> > > > shows the same error as before with test2-mmX.
> > >
> > > Me either.  Unfortunately that patch does five different things so we
> > > cannot easily narrow it down further.
> >
> > Yeah, I know. My next patch is likely to have to do even more
> > unfortunately. Found quite a number more issues with IRQs.
>
> Split it on logical changes if its possible.

I will attempt to as much as possible, but many of the changes rely on each 
other. Yuck.

