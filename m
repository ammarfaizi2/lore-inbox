Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbUJ0E1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbUJ0E1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbUJ0E1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:27:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8091 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261494AbUJ0E1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:27:05 -0400
Date: Wed, 27 Oct 2004 00:26:44 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Ed Tomlinson <edt@aei.ca>
cc: Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
In-Reply-To: <200410261719.56474.edt@aei.ca>
Message-ID: <Pine.LNX.4.44.0410270019170.21548-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, Ed Tomlinson wrote:

> The issue is that Linus _has_ changed the development model.  What we have
> now is more flexable and much more responsive to changes.  This does 
> lead to stable releases that are not quite a stable as some of the previous
> stable series... 

I can't remember a single stable kernel series that was as
stable as the 2.6 kernel.  In 1.2, 2.0, 2.2 and 2.4 there were
huge problems dealing with the rate of change that's required
to fix everybody's problems.

You have to realise that you have to choose between changing
things quickly, or leaving people's bugs unfixed.  When you
have millions of users, you cannot both fix everybody's problems
and keep a low rate of change.

The traditional approach has been opening up a development
kernel branch, but this means lots of fixes and new features
are not present in the stable kernel, and need to be backported
by the various distributions.

All in all, I think the 2.6 kernel is doing significantly better
than any of the stable kernel series I've seen before.

> This is why I suggest a fix/security branch.  The idea being that after
> a month or so of fixes etc it will be a very stable kernel and it will
> not have slowed down development.

This is a good idea, though it is a very fine line between a
fix and a feature.  There needs to be a very clear policy on
which kind of patches are acceptable and which aren't.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

