Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbTJEFfE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 01:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbTJEFfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 01:35:04 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13072
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262970AbTJEFe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 01:34:59 -0400
Date: Sat, 4 Oct 2003 22:34:58 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@redhat.com>
Cc: David Ashley <dash@xdr.com>, linux-kernel@vger.kernel.org
Subject: Re: Idea for improving linux buffer cache behaviour
Message-ID: <20031005053458.GC1205@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	David Ashley <dash@xdr.com>, linux-kernel@vger.kernel.org
References: <200310041534.h94FYv0X007015@xdr.com> <Pine.LNX.4.44.0310041513150.14750-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310041513150.14750-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 03:14:14PM -0400, Rik van Riel wrote:
> On Sat, 4 Oct 2003, David Ashley wrote:
> 
> > Forgive me if this has already been thought of, or is obsolete, or is
> > just plain a bad idea, but here it is:
> 
> Do you also want an answer if the kernel already does
> exactly what you are suggesting ? ;)
> 

Then why doesn't it work better?

> > 1) Lowest access count looked at first to toss
> > 2) If access counts equal, throw out oldest first
> 
> > The net result is commonly used items you very much want to remain in
> > cache always quickly get rated very highly as the system is used.
> 
> Which results in exactly the behaviour you're complaining
> about ;))

So, you use the system, have glibc loaded, and then play a dvd, and now
glibc needs to be re-read because it's not in cache.

Why wasn't glibc (one example) kept in cache with the streaming read from
the dvd?

