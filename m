Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWH0WO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWH0WO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 18:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWH0WO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 18:14:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36487 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751238AbWH0WOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 18:14:55 -0400
Date: Sun, 27 Aug 2006 15:14:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Dong Feng <middle.fengdong@gmail.com>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <200608272339.08092.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608271514130.22931@schroedinger.engr.sgi.com>
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
 <200608272252.48946.ak@suse.de> <Pine.LNX.4.64.0608271404260.22510@schroedinger.engr.sgi.com>
 <200608272339.08092.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006, Andi Kleen wrote:

> x86-64 always uses the spinlocked version (vs i386 using the atomic one)
> and I haven't heard of anybody complaining.

Ia64 has special counters for rwsemaphores. I'd like to see if there is 
any performance loss. mmap_sem is a rwsemaphore. This is performance 
critical.

