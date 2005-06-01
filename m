Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVFAPrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVFAPrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVFAPqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:46:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8439 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261435AbVFAPnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:43:41 -0400
Date: Wed, 1 Jun 2005 08:43:36 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
In-Reply-To: <429DD88B.7168BC77@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0506010842280.23057-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Oleg Nesterov wrote:

> So plist_for_each() works in reverse order, and the comment about
> fifo ordering applies only to plist_first(). Thanks for explanation.
> 
> I don't understand why you are doing it this way, though.

It could be changed. I just did what was natural considering the old 
code.. It would be nice to reverse it though .

Daniel

