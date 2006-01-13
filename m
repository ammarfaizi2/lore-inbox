Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422697AbWAMOfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWAMOfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422698AbWAMOfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:35:12 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:65428 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1422697AbWAMOfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:35:10 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Date: Sat, 14 Jan 2006 01:34:45 +1100
User-Agent: KMail/1.9
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <20060113114607.54c83fc8@localhost> <5.2.1.1.2.20060113124751.00bf2660@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20060113124751.00bf2660@pop.gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601140134.46457.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 00:01, Mike Galbraith wrote:
> At 09:51 PM 1/13/2006 +1100, Con Kolivas wrote:
> >See my followup patches that I have posted following "[PATCH 0/5] sched -
> >interactivity updates". The first 3 patches are what you tested. These
> >patches are being put up for testing hopefully in -mm.
>
> Then the (buggy) version of my simple throttling patch will need to come
> out.  (which is OK, I have a debugged potent++ version)

Your code need not be mutually exclusive with mine. I've simply damped the 
current behaviour. Your sanity throttling is a good idea.

Con
