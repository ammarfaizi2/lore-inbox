Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUCXJWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 04:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUCXJWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 04:22:18 -0500
Received: from ltgp.iram.es ([150.214.224.138]:9344 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S263117AbUCXJWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 04:22:17 -0500
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 24 Mar 2004 10:12:36 +0100
To: "Theodore Ts'o" <tytso@mit.edu>, Joshua Kwan <joshk@triplehelix.org>,
       linux-kernel@vger.kernel.org
Subject: Re: missing files in bk trees?
Message-ID: <20040324091236.GA5556@iram.es>
References: <Pine.LNX.4.58.0403232140160.7713@debian> <pan.2004.03.24.02.50.16.373654@triplehelix.org> <20040324043521.GA28169@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324043521.GA28169@thunk.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 11:35:22PM -0500, Theodore Ts'o wrote:
> On Tue, Mar 23, 2004 at 06:50:16PM -0800, Joshua Kwan wrote:
> > On Tue, 23 Mar 2004 21:41:46 -0500, ameer armaly wrote:
> > > Hi all.
> > > I got the latest kernel tree from linux.bkbits.net, and I try to make
> > > config, and it complains about a missing zconf.tab.h.  However, it has
> > > decrypted the other sccs files, but for some oodd reason it can't find
> > > this particular one.  Suggestions would be appriciated.
> > > Thanks,
> > 
> > you need to do 'bk -r get' in the root of your checkout
> 
> Better to do a "bk -r get -S", actually.  That way files that are
> already checked out won't be created a second time.

Even better is "bk -Ur get -S", which won't check out ChangeSet and the
files in the BitKeeper/ and its subdirectories. The most visible effect
is that it avoids checking out the 3000+ files in BitKeeper/deleted
(3098 as of this morning).

	Regards,
	Gabriel
