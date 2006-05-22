Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWEVEvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWEVEvs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 00:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWEVEvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 00:51:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:39066 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751181AbWEVEvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 00:51:48 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>, Rene Herman <rene.herman@keyaccess.nl>,
       Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <4471305F.40105@bigpond.net.au>
References: <4470CC8F.9030706@keyaccess.nl>
	 <200605221033.49153.kernel@kolivas.org> <1148264043.7643.15.camel@homer>
	 <200605221243.54100.kernel@kolivas.org> <1148267426.21765.15.camel@homer>
	 <4471305F.40105@bigpond.net.au>
Content-Type: text/plain
Date: Mon, 22 May 2006 06:53:00 +0200
Message-Id: <1148273580.9914.3.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-22 at 13:30 +1000, Peter Williams wrote:
> What about the batch tasks?  How do you ensure that they don't get 
> starved?  Remember they're "batch" tasks not "background" tasks.
> 

Here, batch means background.  To make them batch as in only static
priority, I'd just do away with the second array.  Batch as background
makes more sense to me, and since it's my ball and my playground... ;-)

	-Mike

