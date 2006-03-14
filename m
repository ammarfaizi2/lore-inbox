Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWCNWCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWCNWCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWCNWCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:02:43 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:32909 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S964785AbWCNWCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:02:41 -0500
Date: Tue, 14 Mar 2006 23:02:31 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
In-Reply-To: <20060314101811.GA10450@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603142256050.1291-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> [...]
> no. We have to run deadlock detection to avoid things like circular lock
> dependencies causing an infinite schedule+wakeup 'storm' during priority
> boosting. (like possible with your wakeup based method i think)
No, all tasks would just settle on the highest priority and then the
wakeups would stop.

Esben


