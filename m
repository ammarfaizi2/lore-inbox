Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUG1VFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUG1VFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUG1VFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:05:06 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:34739 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S263847AbUG1VEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:04:21 -0400
From: Carsten Rietzschel <cr7@os.inf.tu-dresden.de>
Organization: TU Dresden - Operating System Group 
To: "Saksena, Manas" <Manas.Saksena@timesys.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
Date: Wed, 28 Jul 2004 22:59:20 +0200
User-Agent: KMail/1.6.82
Cc: "Lee Revell" <rlrevell@joe-job.com>, "Ingo Molnar" <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Lenar L?hmus" <lenar@vision.ee>, "Andrew Morton" <akpm@osdl.org>,
       "Arjan van de Ven" <arjanv@redhat.com>,
       "Wood, Scott" <Scott.Wood@timesys.com>
References: <3D848382FB72E249812901444C6BDB1D036EDFD3@exchange.timesys.com>
In-Reply-To: <3D848382FB72E249812901444C6BDB1D036EDFD3@exchange.timesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407282259.20577.cr7@os.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> i've uploaded -L2:
>
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-L2
>

While trying to combine voluntary-preempt-2.6.8-rc2-L2 with software suspend 2 
(swsusp2) I noticed that:
a) with voluntary-preempt = 3
      - writing suspend image to disk is very slow
      - resume fails !
b) with voluntary-preempt = 2
      - writing suspend image to disk is very slow
      - resume works but very slow
c) with voluntary-preempt = 1/0
      - all works as expected

It might be interesting for you to test it with suspend(1) / pm_disk (sorry, 
these don't work for me). I wonder if they'll also fail.

Regards,
Carsten
