Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbSLFRoo>; Fri, 6 Dec 2002 12:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSLFRoo>; Fri, 6 Dec 2002 12:44:44 -0500
Received: from mail.ithnet.com ([217.64.64.8]:36622 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S264910AbSLFRon>;
	Fri, 6 Dec 2002 12:44:43 -0500
Date: Fri, 6 Dec 2002 18:52:23 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
Message-Id: <20021206185223.1708a94e.skraw@ithnet.com>
In-Reply-To: <20021206060135.GC21070@alpha.home.local>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>
	<1039124530.18881.0.camel@rth.ninka.net>
	<20021205140349.A5998@ns1.theoesters.com>
	<3DEFD845.1000600@drugphish.ch>
	<20021205154822.A6762@ns1.theoesters.com>
	<20021206060135.GC21070@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002 07:01:35 +0100
Willy Tarreau <willy@w.ods.org> wrote:

> On Fri, Dec 06, 2002 at 12:59:38AM +0100, Roberto Nibali wrote:
> <snip>
> > Oops, right. I forgot the HW LBs that do triangulation. I wonder 
> > however, why one wants to use a HW LB and not configure it to work in 
> > NAT mode.
> 
> Because when you have to deal with thousands of session per second, NAT is
> really a pain in the ass. When you have to consider security, NAT is a pain
> too because it makes end to end tracking much more difficult when you deal
> with multiple proxy levels.

Oh, a poor soul who experienced my everyday life ... ;-)
netfilter-NAT may be a real nice choice for your-cool-server-at-home. Talking
about many thousand NATted sessions you may as well flush it through the
toilet. sorry for the open words.
In complete contrary I have _never_ experienced problems with the hidden patch
(after correct setup of the boxes). And for another reason: it is plain simple.

-- 
Regards,
Stephan
