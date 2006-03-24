Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWCXL4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWCXL4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWCXL4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:56:00 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:32205 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932603AbWCXL4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:56:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
Date: Fri, 24 Mar 2006 22:55:44 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
References: <1143198208.7741.8.camel@homer> <1143199295.7741.29.camel@homer> <1143199493.7741.32.camel@homer>
In-Reply-To: <1143199493.7741.32.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603242255.44865.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 22:24, Mike Galbraith wrote:
> patch 5/6
>
> This patch tightens timeslice accounting the rest of the way, such that
> a task which has received more than it's slice due to missing with the
> timer interrupt will have the excess deducted from their next slice.
>
> signed-off-by: Mike Galbraith <efault@gmx.de>

Looks ok.

Cheers,
Con
