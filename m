Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270806AbTHSPtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270808AbTHSPtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:49:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:60323 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270806AbTHSPtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:49:45 -0400
Date: Tue, 19 Aug 2003 08:45:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: rob@landley.net
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: headers
Message-Id: <20030819084531.768d5823.rddunlap@osdl.org>
In-Reply-To: <200308190855.07181.rob@landley.net>
References: <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl>
	<bhrvfh$394$1@cesium.transmeta.com>
	<200308190855.07181.rob@landley.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 08:55:06 -0400 Rob Landley <rob@landley.net> wrote:

| On Monday 18 August 2003 21:45, H. Peter Anvin wrote:
| > Followup to:  <UTC200308181907.h7IJ7im12407.aeb@smtp.cwi.nl>
| > By author:    Andries.Brouwer@cwi.nl
| > In newsgroup: linux.dev.kernel
| >
| > >     From garzik@gtf.org  Mon Aug 18 20:14:47 2003
| > >
| > >     I support include/abi, or some other directory that segregates
| > >     user<->kernel shared headers away from kernel-private headers.
| > >
| > >     I don't see how that would be auto-generated, though.  Only created
| > >     through lots of hard work :)
| > >
| > > Yes, unfortunately. I started doing some of this a few times,
| > > but it is an order of magnitude more work than one thinks at first.
| > > Already the number of include files is very large.
| > > And the fact that it is not just include/abi but involves the
| > > architecture doesn't make life simpler.
| > >
| > > No doubt we must first discuss a little bit, but not too much,
| > > the desired directory structure and naming.
| > > Then we must do 5% of the work, and come back to these issues.
| > >
| > > In case people actually want to do this, I can coordinate.
| > >
| > > In case people want to try just one file, do signal.h.
| >
| > Oh yes, this is a whole lot of work.
| 
| But is it 2.6 work, or 2.8 work?

I think that we are currently discussing it as 2.7 work.

--
~Randy
"Everything is relative."
