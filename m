Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRC0TP7>; Tue, 27 Mar 2001 14:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131482AbRC0TPt>; Tue, 27 Mar 2001 14:15:49 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:23170 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S131481AbRC0TPl>;
	Tue, 27 Mar 2001 14:15:41 -0500
Date: Tue, 27 Mar 2001 11:14:57 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS phenomenon with 2.4.2 ac24/ac12
In-Reply-To: <317470000.985716174@tiny>
Message-ID: <Pine.LNX.4.21.0103271113410.7500-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Chris Mason wrote:

> Just to make sure I understand, you had the exact same errors before
> running fsck?  Same files could not be deleted?
Correct.

> > I think this is a problem with the reiserfs code in the kernel. I never
> > ran reiserfsck before this problem surfaced. The problem arose in the
> > netscape cache directory with lots of small files. Guess the tail handling
> > is not that stable yet?
> 
> I wish I could blame it on the tail code ;-)  None of the bugs fixed there
> would have caused this, and they should be completely unrelated.  I'll try
> some tests in oom situations to try and reproduce.  It could also be caused
> by hashing errors.  If you formatted with r5 hash, was the partition ever
> incorrectly detected as tea hash?

No idea. I never got that deep into reiser.

> > How do I get rid of the /a/yy directory now?
> 
> With fsck.  I'll grab the latest today and make sure it can fix this bug.
> Until then, mv /a/yy /a/yy.broken and mkdir /a/yy.

/a/yy is already a "broken" dir moved out of the way.

