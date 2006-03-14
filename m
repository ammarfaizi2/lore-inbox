Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751915AbWCNMg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWCNMg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWCNMg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:36:28 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:42885 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751915AbWCNMg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:36:28 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
Date: Tue, 14 Mar 2006 23:36:08 +1100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1142329861.9710.16.camel@homer> <1142339099.11303.12.camel@homer> <200603142329.31281.kernel@kolivas.org>
In-Reply-To: <200603142329.31281.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603142336.08816.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tuesday 14 March 2006 23:24, Mike Galbraith wrote:
> > The very
> > code responsible for good interbench numbers is also responsible for
> > starvation problems.  It's the long sleep logic.  That logic makes my
> > box suck rocks under thud and irman2.

Oh and I do appreciate that an ultimately interactive design may well be also 
ultimately exploitable. Interbench never claimed to test for exploits.

Cheers,
Con
