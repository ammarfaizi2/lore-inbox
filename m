Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWBMHf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWBMHf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWBMHf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:35:26 -0500
Received: from mail.gmx.net ([213.165.64.21]:49849 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751087AbWBMHf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:35:26 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, gcoady@gmail.com,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200602131815.34874.kernel@kolivas.org>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602131708.52342.kernel@kolivas.org> <1139812538.7744.8.camel@homer>
	 <200602131815.34874.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 08:41:04 +0100
Message-Id: <1139816464.8425.8.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 18:15 +1100, Con Kolivas wrote:
> On Monday 13 February 2006 17:35, MIke Galbraith wrote:
> >
> > Ok, we're basically in agreement on these changes, it's just a matter of
> > when.  As maintainer, Ingo has to weigh the benefit, danger, etc etc.
> 
> Aye and do note the change to the idle detection code currently in -mm will 
> already make substantial difference there, possibly related to fluctuating 
> behaviour.

Possibly...  but there also lies a two edged sword.  Previously, some
bad boys were being truncated back to user_prio 17.  In mm, that's no
longer true.

	-Mike

