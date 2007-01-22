Return-Path: <linux-kernel-owner+w=401wt.eu-S1751628AbXAVLCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbXAVLCs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 06:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbXAVLCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 06:02:48 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:37621 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbXAVLCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 06:02:47 -0500
X-Originating-Ip: 74.109.98.130
Date: Mon, 22 Jan 2007 06:02:07 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Nicholas Miell <nmiell@comcast.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
Subject: Re: [PATCH] Introduce simple TRUE and FALSE boolean macros.
In-Reply-To: <45B495F9.4@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0701220556580.22914@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6>
 <1169401892.2999.1.camel@entropy> <Pine.LNX.4.64.0701211430020.17235@CPE00045a9c397f-CM001225dbafb6>
 <45B495F9.4@yahoo.com.au>
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

On Mon, 22 Jan 2007, Nick Piggin wrote:

> Robert P. J. Day wrote:
>
> > by adding (temporarily) the definitions of TRUE and FALSE to
> > types.h, you should then (theoretically) be able to delete over
> > 100 instances of those same macros being *defined* throughout the
> > source tree. you're not going to be deleting the hundreds and
> > hundreds of *uses* of TRUE and FALSE (not yet, anyway) but, at the
> > very least, by adding two lines to types.h, you can delete all
> > those redundant *definitions* and make sure that nothing breaks.
> > (it shouldn't, of course, but it's always nice to be sure.)
>
> Doesn't seem very worthwhile, and it legitimises this definition
> we're trying to get rid of.

hmmmmmmmm ... apparently, you totally missed my use of the important
word "temporarily":

  $ grep -r "temporary hack" . | wc -l
  16

rday
