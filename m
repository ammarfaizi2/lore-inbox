Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbSJ1SqH>; Mon, 28 Oct 2002 13:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbSJ1SqH>; Mon, 28 Oct 2002 13:46:07 -0500
Received: from bozo.vmware.com ([65.113.40.131]:47111 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261474AbSJ1SqG>; Mon, 28 Oct 2002 13:46:06 -0500
Date: Mon, 28 Oct 2002 10:53:36 -0800
From: chrisl@vmware.com
To: Rik van Riel <riel@conectiva.com.br>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Robert Love <rml@tech9.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Message-ID: <20021028185336.GC1454@vmware.com>
References: <20021026004320.GA1676@werewolf.able.es> <Pine.LNX.4.44L.0210261746520.1697-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210261746520.1697-100000@imladris.surriel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, we care about that because vmware see a different CPU number from
the one reported by the customer. And HT twins cpu is consider 1.3x
instead of 2x.

Cheers

Chris

On Sat, Oct 26, 2002 at 05:48:11PM -0200, Rik van Riel wrote:
> On Sat, 26 Oct 2002, J.A. Magallon wrote:
> 
> > Summary:
> 
> > - each package can handle several (someone said 128+ ;) ) processor cores.
> >   We really do not mind if they are really independent (power4) or not
> >   (xeon, ht)
> 
> Here is the big opinion of difference.  Apparently people _do_
> care, otherwise they would have never asked for HT evil twins
> to be reported separately in /proc.
> 
> kind regards,
> 
> Rik
> -- 
> Bravely reimplemented by the knights who say "NIH".
> http://www.surriel.com/		http://distro.conectiva.com/
> Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
> 


