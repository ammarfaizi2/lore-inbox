Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTGALqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 07:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTGALqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 07:46:14 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37135 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262257AbTGALqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 07:46:12 -0400
Subject: Re: [PATCH] patch-O1int-0306302317 for 2.5.73 interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200307011931.24586.kernel@kolivas.org>
References: <200307010029.19423.kernel@kolivas.org>
	 <200307010754.35804.kernel@kolivas.org>
	 <1057049984.587.1.camel@teapot.felipe-alfaro.com>
	 <200307011931.24586.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1057060831.603.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 01 Jul 2003 14:00:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 11:31, Con Kolivas wrote:
> On Tue, 1 Jul 2003 18:59, Felipe Alfaro Solana wrote:
> > I'm using 1000HZ. With respect to X, I haven't noticed any major
> > difference. Should I? I haven't tested it under very heavy loads, but
> > under normal workloads, it behaves a little better than its predecesors.
> 
> I'd say it would depend on the graphic card. On a sis630 even with a p3 1133 
> it is embarassingly jerky under even the slightest of loads without my patch. 
> However, it is as good now without the granularity patch as earlier with the 
> granularity.

When I say "X feels jerky", I mean that I can notice the scheduler is
not giving the X server enough CPU cycles (I mean, a continuous,
smaller, but more frequent CPU timeslice) to perform window movement and
redrawing fast enough to get ~25fps. Also, I don't think it's related to
the video card. The combo patch I did with Mike's + Ingo's enhacements
works beautifully for me.

