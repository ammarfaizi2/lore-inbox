Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266077AbUAFGjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 01:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266080AbUAFGjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 01:39:10 -0500
Received: from unthought.net ([212.97.129.88]:25311 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S266077AbUAFGjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 01:39:08 -0500
Date: Tue, 6 Jan 2004 07:39:06 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Bastiaan Spandaw <lkml@becobaf.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 affected?
Message-ID: <20040106063906.GB27889@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Bastiaan Spandaw <lkml@becobaf.com>,
	Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
References: <1073320318.21198.2.camel@midux> <Pine.LNX.4.58.0401050840290.21265@home.osdl.org> <1073326471.21338.21.camel@midux> <Pine.LNX.4.58.0401051027430.2115@home.osdl.org> <20040105193817.GA4366@lsc.hu> <20040105224855.GC4987@louise.pinerecords.com> <1073348624.1790.43.camel@louise3.void.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073348624.1790.43.camel@louise3.void.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 01:23:44AM +0100, Bastiaan Spandaw wrote:
...
> Not sure if this works or not.
> According to a slashdot comment this is proof of concept code.
> 
> http://linuxfromscratch.org/~devine/mremap_poc.c

A few tests, all on IA32, all as non-root user:

RedHat 5.2, (vanilla 2.0.39) = no effect
RedHat 6.2, (vanilla 2.4.18) = instant reboot
RedHat 7.2, (redhat 2.4.9-7) = instant reboot
Debian 2.2, (vanilla 2.2.19) = no effect
SuSE 7.3, (suse 2.4.10-4GB) = instant reboot

Cheers,

 / jakob

