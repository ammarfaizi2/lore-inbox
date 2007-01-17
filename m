Return-Path: <linux-kernel-owner+w=401wt.eu-S1751050AbXAQW5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbXAQW5d (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbXAQW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:57:33 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:58003 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbXAQW5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:57:32 -0500
X-Originating-Ip: 74.109.98.130
Date: Wed, 17 Jan 2007 17:51:55 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Valdis.Kletnieks@vt.edu
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: "obsolete" versus "deprecated", and a new config option?
In-Reply-To: <200701172254.l0HMsDMK022934@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0701171749430.4760@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6>
 <200701172154.l0HLs3BM021024@turing-police.cc.vt.edu>           
 <Pine.LNX.4.64.0701171654480.4298@CPE00045a9c397f-CM001225dbafb6>
 <200701172254.l0HMsDMK022934@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Valdis.Kletnieks@vt.edu wrote:

> On Wed, 17 Jan 2007 17:04:20 EST, "Robert P. J. Day" said:
>
> > > How much of the 'OBSOLETE' code should just be labelled 'BROKEN'
> > > instead?
> >
> > the stuff that's actually "broken."  :-)
>
> Right - the question is how much code qualifies as either/both, and
> which we should use when we encounter the random driver that's both
> obsolete *and* broken...

that's entirely a judgment call on the part of the code's maintainer.
if something is both obsolete and broken, then make it depend on
*both* OBSOLETE and BROKEN if you want.  no big deal.

rday
