Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUBJVxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 16:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUBJVwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 16:52:50 -0500
Received: from thunk.org ([140.239.227.29]:64458 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261731AbUBJVwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 16:52:46 -0500
Date: Tue, 10 Feb 2004 16:52:25 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040210215225.GA1666@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Bill Davidsen <davidsen@tmr.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <1ne1M-1Oc-1@gated-at.bofh.it> <4029364F.9030905@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4029364F.9030905@tmr.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 02:51:43PM -0500, Bill Davidsen wrote:
> Sorry, last reply "just went" for some reason... ijn any case I hope the 
> number and tone of replies has shown that a number of people DO care, 
> and that "you can just program around it with your effort instead of 
> mine" isn't going to be popular.
> 
> In other words, this sounds more like 2.7 material where people expect 
> things to change than something which should just suddenly break in 2.6. 
> Violation of Plauger's Law of Least Astonishment and all that.

I think the discussion has always been that this would be a 2.7 item.  

However, it might be useful to make 2.6 start issueing printk's *now*
when a program uses a BSD pty, so that application programs have
plenty of notice that they will be going away.

						- Ted
