Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTEMUHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTEMUHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:07:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48649 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262175AbTEMUF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:05:56 -0400
Date: Tue, 13 May 2003 16:13:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm3
In-Reply-To: <20030509141012.GD2059@in.ibm.com>
Message-ID: <Pine.LNX.3.96.1030513161024.18019C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, Dipankar Sarma wrote:

> I am wondering what we should do with this patch. The RCU stats display
> the #s of RCU requests and actual updates on each CPU. On a normal system
> they don't mean much to a sysadmin, so I am not sure if it is the right
> thing to include this feature. OTOH, it is extremely useful to detect
> potential memory leaks happening due to, say a CPU looping in
> kernel (and RCU not happening consequently). Will a CONFIG_RCU_DEBUG
> make it more palatable for mainline ?

Are there similar things, inplace or in patches? Perhaps a menu section
for kernel metrics and a nice little niche in /proc to display them?
Things like this are helpful when tuning a kernel, but perhaps not wanted
for the minimalist (like embedded) configs.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

