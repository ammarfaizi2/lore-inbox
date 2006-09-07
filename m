Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751828AbWIGSdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbWIGSdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWIGSdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:33:23 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:54721 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751828AbWIGSdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:33:23 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Date: Thu, 7 Sep 2006 18:33:15 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <edpolb$fea$1@taverner.cs.berkeley.edu>
References: <ednsma$hbt$1@taverner.cs.berkeley.edu> <20060907160055.17688.qmail@web36604.mail.mud.yahoo.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1157653995 15818 128.32.168.222 (7 Sep 2006 18:33:15 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Thu, 7 Sep 2006 18:33:15 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler  wrote:
>That all depends on how important getting
>an evaluation complete is to you.

Getting an evaluation complete is of approximately zero importance to me.
I do want the system to be secure, but if the evaluators are ignorant of
basic security principles, then I don't much care what they may think.
Like I said, technical merit is a lot more important to me than pleasing
those who can't think clearly about security.  Frankly, I don't give a
fig what such evaluators think.

If you think there is a good technical argument against this patch, then
I encourage you to state that argument for yourself, without reference
to what evaluators may or may not think.  Appeals to authority do not
persuade me -- especially when the so-called "authority" doesn't appear
to know how to think clearly about security.

>And, they
>do have a point, which is why does it make
>sense to use the same privilege mechanism
>for you security policy as you do for your
>resource management policy.

I didn't think this patch had much of anything to do with resource
management.  I thought this patch was about POSIX-like capabilities.
Resource management isn't relevant here.  Can we talk about this patch,
instead of talking about why some other system of yours got hassled by
the evaluators?

>No, they were very clear that they felt that
>use of the privelege ought to be an indication
>that policy was being violated, and they were
>correct.

That's silly.  There's no justification for that view.  What does
"use of privilege" mean?  *Every* process has some privilege or other.
I think what you mean is that "any process which has privilege above some
baseline should be an indication that policy was violated".  But their
mistake was in getting confused over what the right baseline is, for the
purposes of that heuristic.

If the evaluators thought that a system where every application you
run automatically receives privilege to, e.g., delete all your files is
better than a system where only some applications receive privilege to
delete all your files -- then maybe they need to learn a little more
about the principle of least privilege.
