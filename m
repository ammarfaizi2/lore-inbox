Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTCMHs6>; Thu, 13 Mar 2003 02:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbTCMHs6>; Thu, 13 Mar 2003 02:48:58 -0500
Received: from thunk.org ([140.239.227.29]:12474 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262190AbTCMHs5>;
	Thu, 13 Mar 2003 02:48:57 -0500
Date: Thu, 13 Mar 2003 02:59:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Larry McVoy <lm@work.bitmover.com>, John Bradford <john@grabjohn.com>,
       "H. Peter Anvin" <hpa@zytor.com>, dana.lacoste@peregrine.com,
       linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030313075915.GB1736@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Larry McVoy <lm@work.bitmover.com>,
	John Bradford <john@grabjohn.com>, "H. Peter Anvin" <hpa@zytor.com>,
	dana.lacoste@peregrine.com, linux-kernel@vger.kernel.org,
	lm@bitmover.com
References: <3E6F6E84.1010601@zytor.com> <200303121757.h2CHveVF001517@81-2-122-30.bradfords.org.uk> <20030312180304.GA30788@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312180304.GA30788@work.bitmover.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 10:03:04AM -0800, Larry McVoy wrote:
> > I thought that BK has been able to export everything to a text file
> > since the first version.
> 
> bk export -tpatch -r1.900 > patch.1.900
> bk changes -v -r1.900 > comments.1.900
> 
> Been there forever.

More importantly, even if someone isn't allowed to use the BK command
line tool because once upon time, a long time ago, they submitted a
patch to arch or subversion, they can still find someone is allowed to
set up a bk daemon under the terms of the FUL, connect to the BK
daemon using a http client, and extract the full diff of any changeset
that way.  This doesn't have to be the bkd on bkbits.net; anyone who
is authorized to use BK under the terms of the FUL can set up a bk
daemon to be listening on a port of any machine for which they have
shell access (it doesn't even require root privs).  And every last
changeset can always be made available using this path.

So to the people are complaining that they won't be able to get out
their data if a future version of BK uses a more powerful
representation than SCCS files ---- would you like some more whine
with your cheese?

						- Ted
