Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267512AbUHSXIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267512AbUHSXIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUHSXGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:06:23 -0400
Received: from sophie.6s.nl ([82.192.75.250]:51108 "EHLO sophie.6s.nl")
	by vger.kernel.org with ESMTP id S267493AbUHSXCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:02:43 -0400
Subject: Re: network regression using 2.6.8.x behind Cisco 1712
From: Bastiaan Spandaw <lkml@becobaf.com>
To: =?iso-8859-2?Q?Ond=F8ej_Sur=FD?= <ondrej@sury.org>
Cc: solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
In-Reply-To: <1092899789.5191.1.camel@ondrej.sury.org>
References: <1092817247.5178.6.camel@ondrej.sury.org>
	 <1092849905.26056.17.camel@localhost.localdomain>
	 <1092899789.5191.1.camel@ondrej.sury.org>
Content-Type: text/plain; charset=iso-8859-2
Message-Id: <1092956561.3760.7.camel@louise3.6s.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 01:02:41 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 09:16, Ondøej Surý wrote: 
> On Wed, 2004-08-18 at 18:25 +0100, Alan Cox wrote:
> > On Mer, 2004-08-18 at 09:20, Ondøej Surý wrote:
> > > It could be some bug in IOS, but it is triggered by some change between
> > > 2.6.7 and 2.6.8.  Any hints what should I try or where to look?
> > > I could try some -pre and -rc kernel to locate where this was
> > > introduced, but at least try to hint me which version should be
> > > considered, I am not so willing to compile all -preX and -rcX, but could
> > > do that if neccessary to hunt this regression.
> > 
> > echo "0" >/proc/sys/net/ipv4/tcp_window_scaling see if that helps.
> 
> Yep, that helped.  Thanks a lot.
> 
> > If so then suspect something like the cisco or upstream router.
> 
> I will report this to my local Cisco support partner.

I too have this problem. (cisco 837 running
c837-k9o3sy6-mz.123-4.XG1.bin)

Adjusting the window scaling helped me too.

If you get an answer from cisco I'd greatly appreciate hearing about it.

Regards,

Bastiaan

