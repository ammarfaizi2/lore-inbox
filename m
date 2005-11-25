Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbVKYKLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbVKYKLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 05:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbVKYKLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 05:11:32 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:9057 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1751424AbVKYKLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 05:11:32 -0500
Date: Fri, 25 Nov 2005 11:09:24 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Nick Warne <nick@linicks.net>
cc: Ian McDonald <iam@st-andrews.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OT] 1500 days uptime.
In-Reply-To: <200511242258.15953.nick@linicks.net>
Message-ID: <Pine.LNX.4.63.0511251106170.6764@gockel.physik3.uni-rostock.de>
References: <200511242147.45248.nick@linicks.net> <200511242235.23724.nick@linicks.net>
 <438641F8.4030709@st-andrews.ac.uk> <200511242258.15953.nick@linicks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005, Nick Warne wrote:
> On Thursday 24 November 2005 22:43, Ian McDonald wrote:
> >
> > Talking of things wrapping, I see the load average counter rolls over at
> > 1024. Any hints on getting real load averages when they're above 1024?

You need to change LOAD_FREQ, FSHIFT, and EXP_1, EXP_5, EXP_15 in
<linux/sched.h>.

  http://sosdg.org/~coywolf/lxr/source/include/linux/sched.h?v=2.6.14#L69

Tim
