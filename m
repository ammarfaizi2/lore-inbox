Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVADW5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVADW5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVADWzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:55:08 -0500
Received: from mail.dif.dk ([193.138.115.101]:36245 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262397AbVADWyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:54:25 -0500
Date: Wed, 5 Jan 2005 00:05:45 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Nicholas Berry <nikberry@med.umich.edu>
Cc: grendel@caudium.net, willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
In-Reply-To: <s1dad55b.011@med-gwia-02a.med.umich.edu>
Message-ID: <Pine.LNX.4.61.0501050001240.3492@dragon.hygekrogen.localhost>
References: <s1dad55b.011@med-gwia-02a.med.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Nicholas Berry wrote:

> >>> Willy Tarreau <willy@w.ods.org> 01/04/05 5:05 PM >>>
> >> Oh, while I'm at it, are you using hyperthreading, and if so, could
> you
> >> disable it ? I have seen many cases where it degrades performances
> >> significantly (eg: highly loaded user space network applications).
> 
> >Willy
> 
> Indeed. AIX (sorry) 5.3 on POWER5 explicitly disables SMT (IBM
> hyperthreading) if the load doesn't warrant it.
> 
Heh, yeah, that's pretty funky. I was initially pretty baffled first time 
topas on a AIX 5.3 box showed me I had 6 CPU's but quitting it and 
starting it 2sec later showed me 8 CPU's (box has 4 physical CPUs). That 
send me hunting through docs. On the surface it seems like a nice feature, 
but if it makes any real difference or not I've had difficulty in 
determining.

-- 
Jesper Juhl

