Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVD1Uzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVD1Uzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVD1Uzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:55:49 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:43440 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262176AbVD1Uzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:55:38 -0400
Date: Thu, 28 Apr 2005 16:55:36 -0400
To: "Theodore Ts'o" <tytso@mit.edu>, Davy Durham <pubaddr2@davyandbeth.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 issue..
Message-ID: <20050428205536.GA2297@csclub.uwaterloo.ca>
References: <4270FA5B.5060609@davyandbeth.com> <20050428200908.GB6669@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428200908.GB6669@thunk.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 04:09:08PM -0400, Theodore Ts'o wrote:
> What messages were displayed by e2fsck?  What version of the kernel
> are you running?
> 
> No, I haven't heard of any such problems with ext2/3 filesystems.
> This is the first time that someone was reported a specific problem
> with the # of blocks used accounting.  There is the standard "file
> held open so the number of blocks used is greater than blocks reported
> by du", but that won't cause df to display negative numbers.

I think I have seen this once or twice in the past.  A reboot always
made it go away and it didn't seem to come back.  fsck never showed
anything so I assumed it was just the kernel having lost its mind about
the state of the FS.

I think I was using 2.4.18 or so at the time I last saw it.  It is quite
a while ago but it was ext3 as well as far as I recall.

I originally thought my df and company was messed up (since I think I
have seen a case on sparc where the libc/df were out of sync causing
weird output).

I never thought much about it since it didn't seem to be reproduceable
since it never repeated itself.

Len Sorensen
