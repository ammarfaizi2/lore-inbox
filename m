Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTJSLot (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 07:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTJSLot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 07:44:49 -0400
Received: from p508B634F.dip.t-dialin.net ([80.139.99.79]:49837 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP id S262099AbTJSLos
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 07:44:48 -0400
Date: Sun, 19 Oct 2003 13:43:55 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
Message-ID: <20031019114355.GA29062@linux-mips.org>
References: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com> <021501c39618$615619c0$24ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021501c39618$615619c0$24ee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 05:09:36PM +0900, Norman Diamond wrote:

> How to force reallocations even when data are lost, so that the block number
> can still be accessed even though the data will be random or zeroes until it
> gets written again.  How to force reallocations even when data are lost, to
> prevent a different problem (i.e. if the block is not reallocated and then a
> subsequent write appears to succeed, I don't really think that spot on the
> platter has really reliably recovered even if you think so, I think the new
> data might still get lost again in a few milliseconds or minutes).
> 
> > If every other part of your computer is warrantied for 1 year, why should
> > disk drives alone in the cheapest OEM systems carry 3 year warranties?
> 
> Why does RAM carry 6 year warranties?  (Maybe some don't but this is
> common.)

The distribution of RAM failure over time is different.  Most failure of RAM
tend to be in the first few days or even hours.  After that the rate drops
to a very low value for the next few years.  In other words a long warranty
time won't cause alot of cost for the manufacturer nor benefit customers
much.  But it looks good in advertisment ...

  Ralf
