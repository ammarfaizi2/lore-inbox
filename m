Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbTGLT7v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 15:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbTGLT7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 15:59:51 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:63114 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S268410AbTGLT7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 15:59:49 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 13:07:05 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Miguel Freitas <miguel@cetuc.puc-rio.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
In-Reply-To: <1058037226.1196.122.camel@mf>
Message-ID: <Pine.LNX.4.55.0307121303060.4720@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf>  <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
 <1058027672.1196.105.camel@mf>  <Pine.LNX.4.55.0307120922450.4351@bigblue.dev.mcafeelabs.com>
 <1058037226.1196.122.camel@mf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Miguel Freitas wrote:

> On Sat, 2003-07-12 at 13:30, Davide Libenzi wrote:
> Since i upgraded my computer recently it's difficult to compare with the
> experiments i made before. But basically no, i haven't tried to make
> xine smooth under high load. my primary complain was that even a small
> background load caused by KSysGuard (KDE system monitor) could make it
> drop frames from time to time. with nice values like -2 the problem was
> completely fixed.

IMMIC (If My Math Is Correct :) you would need a nice -11 to be completely
sure that your task will not be preempted by an iteractive SCHED_OTHER
(one can go to +5 and the other might go to -5) with the current settings.



- Davide

