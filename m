Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUJ0Ek2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUJ0Ek2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUJ0Ek1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:40:27 -0400
Received: from zamok.crans.org ([138.231.136.6]:63962 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262573AbUJ0EgR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:36:17 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: jfannin1@columbus.rr.com, agk@redhat.com, christophe@saout.de,
       linux-kernel@vger.kernel.org, axboe@suse.de, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<1098731002.14877.3.camel@leto.cs.pocnet.net>
	<20041026123651.GA2987@zion.rivenstone.net>
	<20041026135955.GA9937@agk.surrey.redhat.com>
	<20041026213703.GA6174@rivenstone.net>
	<20041026151559.041088f1.akpm@osdl.org>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Wed, 27 Oct 2004 06:36:16 +0200
In-Reply-To: <20041026151559.041088f1.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 26 Oct 2004 15:15:59 -0700")
Message-ID: <87hdogvku7.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> disait dernièrement que :

> If you have time, please restore dio-handle-eof.patch and then apply the
> below fixup, then retest.  Thanks.

I had time to test this fix; it did not solve the problem. Whereas reverting
the complete dio-handle-eof.patch solved it.

Best regards,

Mathieu

-- 
"We ought to make the pie higher."

George W. Bush
February 15, 2000
Comment made in Columbia, South Carolina during presidential campaign.

