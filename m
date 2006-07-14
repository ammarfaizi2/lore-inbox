Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161110AbWGNOUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbWGNOUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWGNOUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:20:16 -0400
Received: from sonicyouth.fatport.com ([216.187.77.179]:19402 "EHLO
	sonicyouth.fatport.com") by vger.kernel.org with ESMTP
	id S1161110AbWGNOUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:20:15 -0400
Subject: Re: [PATCH 1/2] mm: nonresident page tracking
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Feng Jin <lkmaillist@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <215036450607140155w67df26fan5b2342ead686ce8b@mail.gmail.com>
References: <20060711182936.31293.58306.sendpatchset@lappy>
	 <20060711182943.31293.3449.sendpatchset@lappy>
	 <215036450607140155w67df26fan5b2342ead686ce8b@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 16:19:59 +0200
Message-Id: <1152886799.15525.21.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 16:55 +0800, Feng Jin wrote:
> Hi,
> 
> I have applied the patch on 2.6.18-rc1-mm1, and when boot my system,
> kernel panic occured, :(
> I have tyied debug it with kdb, but panic occured at startup, although
> I have add kdb=early, but it still
> could not debug it. 
> attachment is my config file.

>From the fact that the patch doesn't apply cleanly to .18-rc1-mm1, and
that when I fixup the rejects it does boot, I can reach no other
conclusion than that you blotched it somehow.

This patch was against mainline from the day of the post.

As for your suggestion of putting #ifdef CONFIG_MM_NONRESIDENT all over
the place; have you seen how the nonresident.h file declares empty stubs
for the functions?

Peter

