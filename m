Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUDOQtF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUDOQtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:49:05 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22032 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264329AbUDOQtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:49:02 -0400
Date: Thu, 15 Apr 2004 17:48:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Bill Davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
In-Reply-To: <c5mcoc$s9l$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0404151746140.9558-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Bill Davidsen wrote:
> Hugh Dickins wrote:
> > 
> > The worst that will happen with anonmm's mremap move, is that some
> > app might go slower and need more swap.  Unlikely, but agreed possible.
> 
> It appears that users on small memory machines running kde are not of 
> concern to you. Unfortunately that describes a fair number of people, 
> not everyone has the big memory fast system. I will try to get some 
> reproducible numbers, but "consistently feels faster" is a reason to 
> keep running -aa even if I can't quantify it.

Appearances can be deceptive.  Of course I care about users,
of small or large memory machines, running kde or not.

It appears that you do not understand that we're talking about a
case so rare that we've never seen it in practice, only by testing.

But perhaps we haven't looked out for it enough (no printk), I'd better
put something in to tell us when it does occur, thanks for the reminder.

If -aa consistently feels faster to you, great, go with it:
but I doubt it's because of this issue we're discussing!

Hugh

