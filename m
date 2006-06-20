Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWFTQDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWFTQDE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWFTQDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:03:04 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:958 "EHLO osa.unixfolk.com")
	by vger.kernel.org with ESMTP id S1751369AbWFTQDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:03:03 -0400
Date: Tue, 20 Jun 2006 09:02:59 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix spinlock-debug looping
In-Reply-To: <20060620023216.4995edb9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0606200902440.26762@osa.unixfolk.com>
References: <20060619070229.GA8293@elte.hu> <20060619005955.b05840e8.akpm@osdl.org>
 <20060619081252.GA13176@elte.hu> <20060619013238.6d19570f.akpm@osdl.org>
 <20060619083518.GA14265@elte.hu> <20060619021314.a6ce43f5.akpm@osdl.org>
 <20060619113943.GA18321@elte.hu> <20060619125531.4c72b8cc.akpm@osdl.org>
 <20060620084001.GC7899@elte.hu> <20060620015259.dab285d5.akpm@osdl.org>
 <20060620091505.GA9749@elte.hu> <20060620023216.4995edb9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Andrew Morton wrote:
| Let's just make it a spinlock and be done with it.  Hopefully Dave or
| ccb@acm.org (?) will be able to test it.  I was planning on doing a patch
| tomorrowish.

Our test case is extremely reproducible in about a minute, so
I should be able to give a pretty conclusive answer as to whether
the patch works for our case.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
