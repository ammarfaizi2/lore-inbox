Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUBIVCD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 16:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUBIVCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 16:02:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:23500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265175AbUBIVB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 16:01:59 -0500
Date: Mon, 9 Feb 2004 12:55:30 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mort@wildopensource.com, anton@samba.org, linux-kernel@vger.kernel.org,
       cliffw <cliffw@osdl.org>
Subject: Re: Manfreds patch to distribute boot allocations across nodes
Message-Id: <20040209125530.295ae3e9.rddunlap@osdl.org>
In-Reply-To: <20040209095629.5dd82095.akpm@osdl.org>
References: <20040207042559.GP19011@krispykreme>
	<20040206210428.17ee63db.akpm@osdl.org>
	<20040207090634.GQ19011@krispykreme>
	<20040207110732.4c6ced3f.akpm@osdl.org>
	<20040209162814.GP21486@localhost>
	<20040209095629.5dd82095.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004 09:56:29 -0800 Andrew Morton <akpm@osdl.org> wrote:

| Martin Hicks <mort@wildopensource.com> wrote:
| >
| > 
| > 
| > On Sat, Feb 07, 2004 at 11:07:32AM -0800, Andrew Morton wrote:
| > > Anton Blanchard <anton@samba.org> wrote:
| > > >
| > > >  > Should this not search for the emptiest node?
| > > > 
| > > >  Allocating things round robin avoids a hot node where everything ends up
| > > >  being allocated.
| > > 
| > > Have you any performance measurements for this patch?
| > 
| > Any suggestions on what benchmark to run?
| 
| I guess SDET is the closest thing we have to a "mixed workload".
| -


Cliff White says that re-aim should also work for this.

https://sourceforge.net/projects/re-aim-7/

or use the OSDL STP interface.

--
~Randy
