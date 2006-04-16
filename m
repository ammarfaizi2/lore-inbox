Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWDPGCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWDPGCg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 02:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWDPGCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 02:02:36 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:61656 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750799AbWDPGCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 02:02:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Sun, 16 Apr 2006 16:02:21 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604122127.20322.kernel@kolivas.org> <200604121825.55054.a1426z@gawab.com>
In-Reply-To: <200604121825.55054.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604161602.22177.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 01:25, Al Boldi wrote:
> Con Kolivas wrote:
> > mean 68.7 seconds
> >
> > range 63-73 seconds.
>
> Could this 10s skew be improved to around 1s to aid smoothness?

It turns out to be dependant on accounting of system time which only staircase 
does at the moment btw. Currently it's done on a jiffy basis. To increase the 
accuracy of this would incur incredible cost which I don't consider worth it.

-- 
-ck
