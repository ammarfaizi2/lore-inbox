Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUDCGBI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 01:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUDCGBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 01:01:07 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:29222 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261610AbUDCGBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 01:01:06 -0500
Date: Fri, 2 Apr 2004 22:00:00 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 6/23] mask v2 - Replace cpumask_t with one using mask
Message-Id: <20040402220000.517f1132.pj@sgi.com>
In-Reply-To: <1080954588.9787.152.camel@arrakis>
References: <20040401122802.23521599.pj@sgi.com>
	<20040401131136.792495fa.pj@sgi.com>
	<1080944675.9787.113.camel@arrakis>
	<20040402153518.706d8464.pj@sgi.com>
	<1080954588.9787.152.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yep, I was just reading through that patch.  It's an interesting
> solution, but I'm not quite sure how I feel about it.

It [Patch 24/23] might be seriously broken, for files including both
cpumask and nodemask.  I'm looking at that now.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
