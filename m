Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161197AbWGNDDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbWGNDDE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161206AbWGNDDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:03:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161197AbWGNDDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:03:02 -0400
Date: Thu, 13 Jul 2006 20:02:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: arjan@infradead.org, torvalds@osdl.org, penberg@cs.helsinki.fi,
       mingo@elte.hu, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com
Subject: Re: [patch] lockdep: annotate mm/slab.c
Message-Id: <20060713200234.d30cf1b8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607131944260.31824@schroedinger.engr.sgi.com>
References: <1152763195.11343.16.camel@linuxchandra>
	<20060713071221.GA31349@elte.hu>
	<20060713002803.cd206d91.akpm@osdl.org>
	<20060713072635.GA907@elte.hu>
	<20060713004445.cf7d1d96.akpm@osdl.org>
	<20060713124603.GB18936@elte.hu>
	<84144f020607130858l60792ac0t5f9cdabf1902339c@mail.gmail.com>
	<Pine.LNX.4.64.0607131156060.5623@g5.osdl.org>
	<1152818472.3024.75.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0607131543040.30558@schroedinger.engr.sgi.com>
	<20060713161620.f61d2ac0.akpm@osdl.org>
	<Pine.LNX.4.64.0607131929050.31444@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0607131944260.31824@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 19:46:09 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Could we please remove the fake revert from the git tree immediately?

Let's not do anything immediately, OK?  We're thrashing around here.

> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=fc818301a8a39fedd7f0a71f878f29130c72193d

Not fake - it's a partial reversion of 
2b2d5493e10051694ae3a57ea6a153e3cb4d4488

> 2.6.17 code has also the dropping of the lock.

It doesn't.

> This was no reversion. 
> Maybe there is a problem but then I'd like to hear about it:

It's all in this thread - see Chandra's testing results.

