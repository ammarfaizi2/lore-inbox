Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWGRUyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWGRUyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWGRUyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:54:24 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:63393 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932399AbWGRUyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:54:23 -0400
Date: Tue, 18 Jul 2006 16:46:51 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: CPU numbering & hyperthreading
To: Andrew Athan <aathan_linux_kernel_1542@cloakmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607181649_MC3-1-C55F-72EE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44BC4200.90308@cloakmail.com>

On Mon, 17 Jul 2006 22:05:52 -0400, Andrew Athan wrote:
>
> I have two highly CPU/memory/network intensive processes with 3-5 
> threads each.  I am using sched_setaffinity calls to make sure these two 
> processes never compete for the same physical CPU.  Am I right to assume 
> that CPU #0 and #1 vs CPU #2 and #3 are separate physical CPUs on a 
> 2-CPU w/ hyperthreading box?
> 
> I've spent some time looking, but I did not find documentation on 
> exactly how CPUs are numbered in a hyperthreaded box.

There's no fixed numbering.

If you want to know the die/core/thread layout, check out
Documentation/cputopology.txt.

-- 
Chuck
And did we tell you the name of the game, boy, we call it Riding the Gravy Train.
