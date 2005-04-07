Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVDGG3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVDGG3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 02:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVDGG3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 02:29:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41940 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261454AbVDGG3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 02:29:30 -0400
Date: Thu, 7 Apr 2005 08:29:28 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
Message-ID: <20050407062928.GH24469@wotan.suse.de>
References: <20050330214455.GF10159@redhat.com> <20050331104117.GD1623@wotan.suse.de> <20050407024902.GA9017@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407024902.GA9017@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I realised today that this happens every time X starts up for
> the first time.   I did some experiments, and found that with 2.6.12rc1
> it's gone. Either it got fixed accidentally, or its hidden now
> by one of the many changes in 4-level patches.
> 
> I'll try and narrow this down a little more tomorrow, to see if I
> can pinpoint the exact -bk snapshot (may be tricky given they were
> broken for a while), as it'd be good to get this fixed in 2.6.11.x
> if .12 isn't going to show up any time soon.

Can you supply a strace of the /dev/mem, /dev/kmem accesses of 
your X server? (including the mmaps or read/writes if available)

My X server doesn't seem to cause that.

-Andi
