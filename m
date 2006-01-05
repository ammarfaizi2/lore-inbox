Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWAEXCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWAEXCF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAEXCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:02:05 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:5842 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932158AbWAEXCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:02:04 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: 80 column line limit?
Date: Thu, 5 Jan 2006 23:02:09 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20060105130249.GB29894@vrfy.org>
In-Reply-To: <20060105130249.GB29894@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601052302.09317.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 13:02, Kay Sievers wrote:
> Can't we relax the 80 column line rule to something more comfortable?
> These days descriptive variable/function names are much more valuable,
> I think.
>
> Just by looking at random examples in the tree, seems the 80 column
> rule does more harm than good. I always find myself start shortening
> names just to fit the line limit and not to need to line-wrap a statement.

I've found myself drifting to and from favouring the 80 cols limit in my own 
code. It's a good way of forcing yourself to refactor, which usually works 
out nicely, and I've even managed to write Java that was mostly 80 cols 
(which is a far bigger challenge than C due to the required preceding tab 
depth for a method inside a class..)

> We even use #defines sometimes to access simple structure members and
> the like, only to fit that rule.

This is usually for multiple levels of dereferencing, and it really does help 
readability.

> So, are we sure that 80 columns is still valuable, looking at the
> side-effects of artificially shortended variable/function names and
> line-wrapped statements, caused by this rule?

It's fairly redundant trying to answer this question without the opinion of 
the people that really matter. I'd hazard a guess and say that if you ranked 
kernel contributors by man-hours spent on the kernel, the top ten would all 
think the 80 columns rule was critically important.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
