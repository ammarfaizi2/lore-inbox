Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTIKOQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbTIKOQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:16:47 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:34961 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261226AbTIKOQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:16:01 -0400
Date: Thu, 11 Sep 2003 15:14:51 +0100
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911141451.GA20434@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, richard.brunner@amd.com,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20030911012708.GD3134@wotan.suse.de> <Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org> <20030911160108.5678113b.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911160108.5678113b.ak@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 04:01:08PM +0200, Andi Kleen wrote:

 > > What's wrong with the current status quo that just says "Athlon prefetch
 > > is broken"?
 > It doesn't fix user space for once.

And for another, it cripples the earlier athlons which don't have this
errata. Andi's fix at least makes prefetch work again on those boxes.
It's also arguable that prefetch() helps the older K7's more than the
affected ones.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
