Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTKLWfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 17:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTKLWfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 17:35:37 -0500
Received: from [217.73.128.98] ([217.73.128.98]:11397 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261670AbTKLWfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 17:35:36 -0500
Date: Thu, 13 Nov 2003 00:35:30 +0200
Message-Id: <200311122235.hACMZUDT017881@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: reiserfs 3.6 problem with test9
To: rouquier.p@wanadoo.fr, linux-kernel@vger.kernel.org
References: <87smkt63xu.wl@drakkar.ibe.miee.ru> <1068663075.17051.12.camel@Genesyme>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Philippe <rouquier.p@wanadoo.fr> wrote:
P> Note: I kept the original reiserfs partition with the errors. So if
P> someone needs any log to figure out where the problem comes from I have
P> everything at hand. I'm also willing to perform other tests. 

Errors you've shown from your log suggest that somehow garbage appeared
in some blocks that were supposed to be reiserfs metadata blocks.
How this happened is unclear.
Also lots of people (including myself) use reiserfs on a daily basis with high
loads (and on latest 2.6.0-test kernels, too) and have not seen anything like
that so either there is something wrong with memory or with writing
to your disk, I think.
Of course I might be wrong.
There are disk testing programs out there (sorry forgot the names) (not
badblocks) that put a lot of load on disk and see how it does.
May be you want to try one of those too.

Bye,
    Oleg
