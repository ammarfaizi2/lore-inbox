Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVETUjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVETUjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVETUjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:39:06 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:65254 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261581AbVETUjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:39:00 -0400
Subject: Re: Thread and process dentifiers (CPU affinity, kill)
From: Lee Revell <rlrevell@joe-job.com>
To: Olivier Croquette <ocroquette@free.fr>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <428E45EA.3040603@free.fr>
References: <428CD458.6010203@free.fr>
	 <20050520125511.GC23488@csclub.uwaterloo.ca> <428DF95E.2070703@free.fr>
	 <20050520165307.GG23488@csclub.uwaterloo.ca> <d6l9cs$l1t$1@news.cistron.nl>
	 <428E45EA.3040603@free.fr>
Content-Type: text/plain
Date: Fri, 20 May 2005 16:38:58 -0400
Message-Id: <1116621539.29740.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 22:17 +0200, Olivier Croquette wrote:
> # export LD_ASSUME_KERNEL=2.4.1
> This is a clever way to enable some existing applications that rely on 
> LinuxThreads to continue to work in an NPTL environment, but is a 
> short-term solution. To make the most of the design and performance 
> benefits provided by NPTL, you should update the code for any existing 
> applications that use threading.

Applications that rely on linuxthreads, heh, that's a good one.

The most common use of LD_ASSUME_KERNEL is to force Linuxthreads to be
used in order to work around a bad bug in NPTL 0.60, often present on
Debian systems.  Ubuntu still reports NPTL 0.60, but they at least fixed
the bug for the Hoary release.  The Debian people refuse to.

The issue is very well known to JACK users.

Lee

