Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWCUL7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWCUL7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWCUL7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:59:17 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:44204 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030339AbWCUL7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:59:16 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
Date: Tue, 21 Mar 2006 22:58:45 +1100
User-Agent: KMail/1.9.1
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
References: <20060320122449.GA29718@outpost.ds9a.nl> <200603211409.50331.kernel@kolivas.org> <20060321085352.GA17642@rhlx01.fht-esslingen.de>
In-Reply-To: <20060321085352.GA17642@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603212258.46265.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 March 2006 19:53, Andreas Mohr wrote:
> (and the fact that invoking a function pointer should be similarly
> expensive to a conditional) I don't think it's useful.

Is 

*blah();

as expensive as

if (conditional)
	blah();

I don't know the answer. I just know cmp is expensive. Comments?

Cheers,
Con
