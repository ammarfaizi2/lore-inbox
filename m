Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWBJOUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWBJOUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWBJOUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:20:20 -0500
Received: from gold.veritas.com ([143.127.12.110]:58526 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932104AbWBJOUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:20:19 -0500
Date: Fri, 10 Feb 2006 14:20:52 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Anthony Tippett <atippett@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/swap.c:49
In-Reply-To: <200602101234.44463.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0602101418410.11769@goblin.wat.veritas.com>
References: <43EAB5FF.9030305@gmail.com> <200602101234.44463.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 Feb 2006 14:20:18.0930 (UTC) FILETIME=[1EB6E520:01C62E4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2006, Alistair John Strachan wrote:
> On Thursday 09 February 2006 03:24, Anthony Tippett wrote:
> >
> > It looks like it might be an issue with Xorg and fglrx (ati drivers)
> 
> Could be, no way to tell from the trace. Try to reproduce without the driver.
> 
> > Feb  8 16:50:42 act kernel: kernel BUG at mm/swap.c:49!

It's just fglrx wrapper not uptodate with 2.6.15,
I sent him the wrapper patch offline.

Hugh
