Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbTIEU2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbTIEU1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:27:33 -0400
Received: from pcp02969622pcs.gnscrp01.va.comcast.net ([68.48.95.133]:15246
	"EHLO charon.int.bittwiddlers.com") by vger.kernel.org with ESMTP
	id S265946AbTIEUYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:24:52 -0400
Date: Fri, 5 Sep 2003 16:24:34 -0400
To: Christoph Hellwig <hch@infradead.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test-x] Kernel Oops and pppd segfault
Message-ID: <20030905202430.GA3425@bittwiddlers.com>
References: <1062711059.8011.4.camel@mindfsck>
	<20030905084126.A15120@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905084126.A15120@infradead.org>
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.82 (Needles)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1063225476.b6bd27@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This should fix the oops, but the failure is still strange.
>
> do you already have a ppp device in /dev before loading the module?

Yeah, I posted this problem a few weeks ago but never had an answer.  I
worked around it.  I do have a /dev/ppp already in there but get the 
exact same oops when attempting to run pppd without my patch and while using
devfs

-- 
  Matthew Harrell                          Never raise your hand to your 
  Bit Twiddlers, Inc.                       children - it leaves your
  mharrell@bittwiddlers.com                 midsection unprotected.
