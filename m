Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270346AbTG1RC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 13:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270350AbTG1RC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 13:02:27 -0400
Received: from 213-0-201-143.dialup.nuria.telefonica-data.net ([213.0.201.143]:19858
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S270346AbTG1RCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 13:02:25 -0400
Date: Mon, 28 Jul 2003 19:17:40 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Message-ID: <20030728171740.GB8605@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 27 July 2003, at 15:40:42 +0200,
Ingo Molnar wrote:

> my latest scheduler patchset can be found at:
> 
> 	redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G6
> 
> this version takes a shot at more scheduling fairness - i'd be interested
> how it works out for others.
> 
There a couple of now-famous interactivity tests wher -G6 succeed and
2.6.0-test2 fails.

First, with -G6 I can't make XMMS MP3s skip simply by scrolling a web
page loaded in Mozilla 1.4, no matter how hard I try.

Second, moving a window like mad (show window contents while moving set
to ON) won't freeze X, and with 2.6.0-test2 this could be done in
several seconds of moving the window.

Still, OpenOffice is dog slow when anything else is getting CPU cycles,
but Andrew Morton pointed out on another thread this seems to be a
problem with OpenOffice , not with the scheduler.

Regards,

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test1-bk3)
