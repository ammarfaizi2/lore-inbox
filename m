Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161272AbWGJAHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161272AbWGJAHz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWGJAHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:07:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:9391 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161272AbWGJAHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:07:54 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: use thread_info flags for debug regs and IO   bitmaps
Date: Mon, 10 Jul 2006 02:07:49 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200607091936_MC3-1-C489-B862@compuserve.com> <Pine.LNX.4.64.0607091646210.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607091646210.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100207.49097.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 July 2006 01:48, Linus Torvalds wrote:
> 
> On Sun, 9 Jul 2006, Chuck Ebbert wrote:
> > 
> > After I saw a ~7% gain in task-switch performance, I like it now
> > even without perfmon2 in there.
> 
> So is the 7% performance gain visible with just that single patch 

It came from lmbench which is not particularly stable for context switch
times. Might well be an artifact. It sounds too much too.

-Andi
