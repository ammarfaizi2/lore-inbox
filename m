Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSLJJgb>; Tue, 10 Dec 2002 04:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbSLJJga>; Tue, 10 Dec 2002 04:36:30 -0500
Received: from max.fiasco.org.il ([192.117.122.39]:13828 "HELO
	latenight.fiasco.org.il") by vger.kernel.org with SMTP
	id <S264010AbSLJJga>; Tue, 10 Dec 2002 04:36:30 -0500
Subject: Re: hidden interface (ARP) 2.4.20
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, ratz@drugphish.ch,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021209120814.2eaaef29.skraw@ithnet.com>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>
	<1039124530.18881.0.camel@rth.ninka.net>
	<20021205140349.A5998@ns1.theoesters.com> <3DEFD845.1000600@drugphish.ch>
	<20021205154822.A6762@ns1.theoesters.com>
	<20021208170135.GA354@alpha.home.local> 
	<20021209120814.2eaaef29.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Dec 2002 11:42:54 +0200
Message-Id: <1039513380.2384.90.camel@klendathu.telaviv.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 13:08, Stephan von Krawczynski wrote:

> This is unfortunately not sufficient, not even close to. If you really want to
> have a good idea what is going on you should as well check out what is happening
> with packet sizes a lot smaller than 1500 (normal mtu). Check data rate an
> packet loss with packet sizes around 80 bytes or so to get an idea what bothers
> us :-)

VoIP? :-)

Have you tried those tests with the NAPI network drivers patch? my
experience has been that interrupt live lock is what's hitting you
really hard in the scenarios you described and the NAPI network drivers
patch id supposed to fix that. 


Gilad



-- 
 Gilad Ben-Yossef <gilad@benyossef.com> 
 http://benyossef.com 
 "Denial really is a river in Eygept."

