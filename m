Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVHKQJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVHKQJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVHKQJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:09:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:56719 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932243AbVHKQJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:09:22 -0400
Subject: Re: 2.6.13-rc4-mm1: Divide by zero in find_idlest_group
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200508120127.39436.kernel@kolivas.org>
References: <1123773675.9252.11.camel@kleikamp.austin.ibm.com>
	 <200508120127.39436.kernel@kolivas.org>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 11:09:19 -0500
Message-Id: <1123776559.32056.1.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-12 at 01:27 +1000, Con Kolivas wrote:
> On Fri, 12 Aug 2005 01:21 am, Dave Kleikamp wrote:
> > Should there be any locking around this?  Or should the value of
> > rq->nr_running be saved to a local variable as in this untested patch?
> 
> Very sneaky..
> 
> On initial inspection your patch makes complete sense. I see no point in 
> adding locking to this function as the accuracy is not critical. Want to give 
> your patch a run and then push it to akpm? Thanks!

Okay, I'm testing it now.  It took running overnight to hit the problem
before, so I'll let it run until tomorrow before I push it.

> Cheers,
> Con
-- 
David Kleikamp
IBM Linux Technology Center

