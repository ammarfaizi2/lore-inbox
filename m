Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSGIAdt>; Mon, 8 Jul 2002 20:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSGIAds>; Mon, 8 Jul 2002 20:33:48 -0400
Received: from ns.suse.de ([213.95.15.193]:24581 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315784AbSGIAdr>;
	Mon, 8 Jul 2002 20:33:47 -0400
Date: Tue, 9 Jul 2002 02:36:28 +0200
From: Dave Jones <davej@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] 2.5.25 net/core/Makefile
Message-ID: <20020709023628.A1697@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <20020709001135.GA21383@suse.de> <22345.1026174631@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <22345.1026174631@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Tue, Jul 09, 2002 at 10:30:31AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 10:30:31AM +1000, Keith Owens wrote:
 > > > The valid combination of CONFIG_NET=n, CONFIG_LLC undefined incorrectly
 > >And this breaks the valid combination of CONFIG_NET=y, CONFIG_LLC undef'd

 > ??? That is the bug that I reported.  My patch fixes that bug.

Same bug maybe, but triggered in different ways.
Note the CONFIG_NET change between your report and mine.

With mainline kbuild this isn't an issue, but your fix breaks it.

*shrug*

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
