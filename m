Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUCBKCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 05:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbUCBKCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 05:02:42 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:2722 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261586AbUCBKCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 05:02:32 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Known problems with megaraid under 2.4.25 highmem?
Date: Tue, 2 Mar 2004 11:05:16 +0100
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org, Atul Mukker <atulm@lsil.com>
References: <200402271107.42050.tvrtko@croadria.com> <Pine.LNX.4.58L.0402271548290.18958@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402271548290.18958@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200403021105.16790.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 February 2004 19:52, Marcelo Tosatti wrote:
> > I have experienced an I/O lockup on my dual Xeon server with megaraid
> > adapter when kernel was compiled with highmem and highmem i/o. It
> > happened during compilation of mysql with no other load.
> >
> > Then I recompiled the kernel wo/highmem and everything is stable.
> >
> > As, this server is now in production on different location I cannot do
> > much testing except giving detailed hw info.
>
> Hi,
>
> Not known to me...
>
> Can you get any traces from the lockup? NMI watchdog or sysrq+p and +t?
>
> Did any previous 2.4.x work reliably?

A little bit more on this subject:

Are there any known problems when using userspace irqbalance daemon on this 
hardware or in general? We are currently running vanilla 2.4.25 wo/irqbalance 
and so far I cannot make it lock up.

