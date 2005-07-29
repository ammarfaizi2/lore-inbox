Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVG2Luk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVG2Luk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVG2Luk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:50:40 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:55466 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262529AbVG2LtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:49:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Gabriel Devenyi <ace@staticwave.ca>
Subject: Re: [ck] [ANNOUNCE] Interbench v0.24
Date: Fri, 29 Jul 2005 21:49:12 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200507291310.42203.kernel@kolivas.org> <200507292127.25529.kernel@kolivas.org> <42EA175A.4080008@staticwave.ca>
In-Reply-To: <42EA175A.4080008@staticwave.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507292149.12859.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 21:47, Gabriel Devenyi wrote:
> Thats correct, does it need it?

For the memload, yes it does. I guess for the next version I can drop memload 
if it can't read the swap information rather than not running at all.

Cheers,
Con

> Con Kolivas wrote:
> > On Fri, 29 Jul 2005 21:11, Gabriel Devenyi wrote:
> >>Hello Con,
> >>
> >>Attempting to run this on my 2.6.12-ck3s system results in the following
> >>error:
> >>
> >>sawtooth interbench-0.24 # ./interbench
> >>loops_per_ms unknown; benchmarking...
> >>690936 loops_per_ms saved to file interbench.loops_per_ms
> >>
> >>Could not get memory or swap size
> >>
> >>Bug perhaps? My configuration hasn't changed since interbench 0.23 AFAIK.
> >
> > No swap?
> >
> > Cheers,
> > Con
