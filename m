Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269915AbUJMX2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269915AbUJMX2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269926AbUJMX2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:28:53 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:42475 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269915AbUJMX2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:28:37 -0400
Subject: Re: 4level page tables for Linux
From: Albert Cahalan <albert@users.sf.net>
To: andrea@novell.com
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de
Content-Type: text/plain
Organization: 
Message-Id: <1097709734.2666.10890.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Oct 2004 19:22:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> after you add the 4level, locking will become
> necessary for the pgd, but it's still not needed
> for the pml4.
>
> I'm not very excited about changing the naming,
> of the pgd/pmd/pte so I like to keep it like it is now.
>
> peraphs we could consider pgd4 instead of pml4.
> What does "pml" stands for?

The "pmd" one is certainly nonsense now.
It means "page middle directory".

Numbers for all of them would be easy to deal with.
Like this: pd1, pd2, pd3, pd4...

I'd number going toward the page, because that's
the order in which these things get walked.


