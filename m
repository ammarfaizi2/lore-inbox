Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265938AbUGTQFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbUGTQFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUGTQFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 12:05:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22967 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265938AbUGTQFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 12:05:24 -0400
Date: Tue, 20 Jul 2004 11:52:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Krzysztof Rusocki <kszysiu@iceberg.elsat.net.pl>, cltien@cmedia.com.tw,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] cmpci oops on rmmod + fix
Message-ID: <20040720145242.GA2315@dmt.cyclades>
References: <20040717200704.GD14733@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040717200704.GD14733@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2004 at 10:07:04PM +0200, Adrian Bunk wrote:
> Below is a patch originally sent against 2.6 by
> Krzysztof Rusocki <kszysiu@iceberg.elsat.net.pl> (and already included 
> in 2.6.8-rc1).
> 
> His explanation of the patch was:
> 
> <--  snip  -->
> 
> The cmpci driver included in Linux 2.6.7 causes an oops on rmmod,
> I believe cm_remove should be marked __devexit rather than __devinit.
> 
> <--  snip  -->
> 
> 
> This is an obvious bug, and below is my backport of his fix to 2.4 .
> While I was editing struct cm_driver, I've also converted it to C99 
> initializers (as already done in 2.6).
> 
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

Looks good, applied.

Thanks Adrian.
