Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWAJBFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWAJBFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAJBFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:05:38 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6605 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932129AbWAJBFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:05:38 -0500
Date: Tue, 10 Jan 2006 02:05:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] protect remove_proc_entry
Message-ID: <20060110010541.GA5878@elte.hu>
References: <1135973075.6039.63.camel@localhost.localdomain> <1135978110.6039.81.camel@localhost.localdomain> <20060107033637.458c4716.akpm@osdl.org> <1136834210.6197.10.camel@localhost.localdomain> <1136854761.6197.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136854761.6197.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> FYI
> 
> I just uploaded my 2.6.15-rt2-sr3 which includes the latest patch to 
> fix the bug in remove_proc_entry.
> 
> http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt2-sr3

thanks Steve - i've applied your fixes and have uploaded 2.6.15-rt3 to 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

(other than the version string it is the same as -rt2-sr3.)

	Ingo
