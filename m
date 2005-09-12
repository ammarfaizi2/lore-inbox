Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVILPiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVILPiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 11:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVILPiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 11:38:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63385 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750706AbVILPiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 11:38:08 -0400
Date: Mon, 12 Sep 2005 08:38:02 -0700
From: Paul Jackson <pj@sgi.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050912083802.67756823.pj@sgi.com>
In-Reply-To: <17189.39100.862561.865802@gargle.gargle.HOWL>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
	<Pine.LNX.4.58.0509120732060.3242@g5.osdl.org>
	<17189.39100.862561.865802@gargle.gargle.HOWL>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita wrote:
> static void cpusets_lock(void);
> static void cpusets_unlock(void);

Great minds think alike.  That's exactly what
Linus first proposed, when confronted with this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
