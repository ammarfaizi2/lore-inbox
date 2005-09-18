Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVIRSKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVIRSKx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 14:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVIRSKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 14:10:52 -0400
Received: from [212.76.81.198] ([212.76.81.198]:59652 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932153AbVIRSKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 14:10:52 -0400
From: Al Boldi <a1426z@gawab.com>
To: Willy Tarreau <willy@w.ods.org>, Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Eradic disk access during reads
Date: Sun, 18 Sep 2005 21:08:16 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200509170717.03439.a1426z@gawab.com> <200509181902.17633.vda@ilport.com.ua> <20050918163450.GA1516@alpha.home.local>
In-Reply-To: <20050918163450.GA1516@alpha.home.local>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509182102.32721.a1426z@gawab.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sun, Sep 18, 2005 at 07:02:17PM +0300, Denis Vlasenko wrote:
> > > Also, great meter!  Best of all does not hog the CPU!
> > > Could you add a top3 procs display?
> >
> > What is a "top3 procs display"?

top 3 procs that eat most of the CPU.

> probably something which will turn your tool into sort of a complex and
> unusable one when another session running 'top' could do the trick.

Top is super-expensive.

> Oh, BTW, the first reason I wrote my tool was to avoid copying into
> /dev/null which consumes a small amount of CPU. Thus, I made it a pure
> data eater. It might be interesting to run it instead of 'dd' while your
> tool is running, to see if system usage decreases a bit.

Good idea!

Thanks!

--
Al

