Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263635AbUECK5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUECK5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 06:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUECK5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 06:57:22 -0400
Received: from smtp-out3.xs4all.nl ([194.109.24.13]:783 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S263635AbUECK5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 06:57:21 -0400
Date: Mon, 3 May 2004 12:56:51 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm1: some sort of deadlock occurs under heavy i/o
Message-ID: <20040503105651.GA3509@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20040502112756.GA1463@middle.of.nowhere> <Pine.LNX.4.58.0405021201130.2332@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405021201130.2332@montezuma.fsmlabs.com>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Sun, May 02, 2004 at 12:02:38PM -0400
> On Sun, 2 May 2004, Jurriaan wrote:
> 
> > When I do a _lot_ of I/O in 2.6.6-rc3-mm1, I've seen some sort of
> > deadlock multiple times now.
> 
> Try the following patch from Andrew;
> 
> Index: linux-2.6.6-rc3-mm1/mm/vmscan.c

That does indeed solve the problem here.

Thanks,
Jurriaan
-- 
Mobius strippers only show you their back side.
	Anonymous - Seen on Usenet
Debian (Unstable) GNU/Linux 2.6.6-rc3-mm1 2x6062 bogomips 0.36 0.13
