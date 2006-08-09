Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030556AbWHIGit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbWHIGit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030557AbWHIGit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:38:49 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:49634 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030544AbWHIGis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:38:48 -0400
Date: Wed, 9 Aug 2006 08:35:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Neil Brown <neilb@suse.de>
cc: Michael Tokarev <mjt@tls.msk.ru>, Alexandre Oliva <aoliva@redhat.com>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: modifying degraded raid 1 then re-adding other members is bad
In-Reply-To: <17625.4242.910985.97868@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.61.0608090834060.11585@yvahk01.tjqt.qr>
References: <or8xlztvn8.fsf@redhat.com> <17624.29070.246605.213021@cse.unsw.edu.au>
 <44D8732C.2060207@tls.msk.ru> <17625.4242.910985.97868@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why we're updating it BACKWARD in the first place?
>
>To avoid writing to spares when it isn't needed - some people want
>their spare drives to go to sleep.

That sounds a little dangerous. What if it decrements below 0?


Jan Engelhardt
-- 
