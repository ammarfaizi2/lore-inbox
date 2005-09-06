Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVIFREv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVIFREv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVIFREv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:04:51 -0400
Received: from kanga.kvack.org ([66.96.29.28]:27785 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750760AbVIFREu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:04:50 -0400
Date: Tue, 6 Sep 2005 13:04:07 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Dave Jones <davej@redhat.com>, Alex Davis <alex14641@yahoo.com>,
       Sean <seanlkml@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050906170407.GB31861@kvack.org>
References: <36918.10.10.10.10.1125889201.squirrel@linux1> <20050905034158.97152.qmail@web50213.mail.yahoo.com> <20050905042641.GD4715@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905042641.GD4715@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 12:26:41AM -0400, Dave Jones wrote:
> As someone who gets to read a lot of bug reports from end-users,
> this thing is far from perfect judging by the number of tainted
> oopses I've seen, and not all of them look like stack size issues.

It would make sense to use 4KB pages with a guard page to catch unexpected 
stack overflows.  Then we'd at least catch some of the binary only modules 
with Oops that clearly show who is at fault.

> Helping the cause of binary (or part binary) solutions doesn't solve anything.
> It brings nothing but unsolvable problems, and upset users when their problems
> can't get fixed.

Definately.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
