Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbULRVu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbULRVu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 16:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbULRVu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 16:50:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54699 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261172AbULRVuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 16:50:22 -0500
Date: Sat, 18 Dec 2004 16:45:45 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Simon Byrnand <simon@igrin.co.nz>
Cc: Len Brown <len.brown@intel.com>, Willy Tarreau <willy@w.ods.org>,
       linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>
Subject: Re: 2.4.27 -> 2.4.28 breaks i810-tco watchdog timer
Message-ID: <20041218184545.GB3292@logos.cnet>
References: <20041208054834.GD17946@alpha.home.local> <1102487662.2196.18.camel@d845pe> <6.1.2.0.1.20041210102725.05bdc350@pop3.igrin.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.2.0.1.20041210102725.05bdc350@pop3.igrin.co.nz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 10:29:41AM +1300, Simon Byrnand wrote:
> At 19:34 8/12/2004, Len Brown wrote:
> 
> >On Wed, 2004-12-08 at 00:48, Willy Tarreau wrote:
> >> Hi,
> >>
> >> On Wed, Dec 08, 2004 at 08:59:35AM +1300, Simon Byrnand wrote:
> >> (...)
> >> > e400-e47f : motherboard
> >> > e800-e81f : motherboard
> >> > ec00-ec3f : motherboard
> >> > f000-f00f : Intel Corp. 82801DB Ultra ATA Storage Controller
> >> >   f000-f007 : ide0
> >> >   f008-f00f : ide1
> >> >
> >> > Clearly the IO range the driver is trying to open is already in use
> >> by
> >> > "motherboard". If I check another almost identical machine still
> >> running
> >
> >
> >Does this patch in 2.4.29 help?
> >http://linux.bkbits.net:8080/linux-2.4/cset@41a29b2db1heWGdXTVfdZPyWafsD8g
> 
> Yes! That did the trick. The watchdog timer now loads :-)

<snip>

> Is this patch already in 2.4.29 "for sure" or is it just a proposed patch 
> at this time ? Hopefully it will go in.

Its in 2.4.29 for sure.
