Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312095AbSCQShC>; Sun, 17 Mar 2002 13:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312094AbSCQSgx>; Sun, 17 Mar 2002 13:36:53 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27380
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312095AbSCQSgn>; Sun, 17 Mar 2002 13:36:43 -0500
Date: Sun, 17 Mar 2002 10:37:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Theodore Tso <tytso@mit.edu>, David Rees <dbr@greenhydrant.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mke2fs (and mkreiserfs) core dumps
Message-ID: <20020317183752.GB27249@matchmail.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020313123114.A11658@greenhydrant.com> <20020313205537.GC429@turbolinux.com> <20020313133748.A12472@greenhydrant.com> <20020313215420.GD429@turbolinux.com> <20020315182355.A1123@thunk.org> <20020317072653.GB1150@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020317072653.GB1150@turbolinux.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 12:26:53AM -0700, Andreas Dilger wrote:
> On Mar 15, 2002  18:23 -0500, Theodore Tso wrote:
> > There's also the question
> > whether or not filesize limits should really apply to device files,
> > since the original point of filesize limits were as a simple-minded
> > quota control mechanism, and there seems to be little point to causing
> > attempts to access block deivces to fail --- under what circumstances
> > would this *ever* be considered a useful thing?
> 
> Yes, I have always considered this a kernel bug (introduced in 2.4.10),
> but my (admittedly feeble) attempts to get it fixed were not accepted.
> At one point I thought a fix went into 2.4.18-pre[12] or so, but I
> guess not.  I haven't tried in a while, so maybe I should make another
> attempt.
> 

Was that part of the 2.4.10-pre11 -aa VM merge, or was it from another
seperate patch?

