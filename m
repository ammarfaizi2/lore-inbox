Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbUATTUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUATTUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:20:41 -0500
Received: from main.gmane.org ([80.91.224.249]:51152 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265659AbUATTUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:20:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [PATCH] fix for ide-scsi crash
Date: Tue, 20 Jan 2004 10:46:30 -0800
Message-ID: <87k73m5ugp.fsf@pfaff.stanford.edu>
References: <UTC200401200944.i0K9iRE25868.aeb@smtp.cwi.nl>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:Ya4A9f7XQa1TttfqDN+xgeQwHrk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:

> Yes, it seems we presently have no good mechanism / policy here.
> Patches are noise. If some kernel version works and another doesnt,
> one has to look at the diffs. Whitespace-only diffs are bad,
> I would never submit them. They also needlessly invalidate existing patches.

When one version of a source file works and another doesn't,
`diff -b' or `diff -w' usually does a good job of ignoring
whitespace changes.
-- 
<blp@cs.stanford.edu> <pfaffben@msu.edu> <pfaffben@debian.org> <blp@gnu.org>
 Stanford Ph.D. Candidate - MSU Alumnus - Debian Maintainer - GNU Developer
                              www.benpfaff.org

