Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWHRNah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWHRNah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWHRNah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:30:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23520 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751387AbWHRNah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:30:37 -0400
Subject: Re: [patch 2/5] -fstack-protector feature: Add the Kconfig option
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <44E5BC2C.80708@linux.intel.com>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org>
	 <200608181308.07752.ak@suse.de>
	 <1155900206.4494.141.camel@laptopd505.fenrus.org>
	 <200608181605.19520.ak@suse.de>  <44E5BC2C.80708@linux.intel.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 18 Aug 2006 15:30:14 +0200
Message-Id: <1155907814.4494.187.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 15:10 +0200, Arjan van de Ven wrote:
> Andi Kleen wrote:
> >> the binary search argument in this case is moot, just having a config
> >> option doesn't break anything compile wise and each later step is
> >> self-compiling..
> > 
> > Not true when the config used for the binary search has stack protector
> > enabled.
> >
> oh? I thought I was pretty careful about that
> 
> looking over the patches again I can't find any reason for a non-compiling/working kernel; at any step..

I just compiled each step separately [*] and they all compile just fine,
and will work just fine as well...



[*] <shameless plug>thanks to the 2 1/2 minute full kernel compile time
of my new Intel box with Woodcrest cpus </shameless plug>

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

