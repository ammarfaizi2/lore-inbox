Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310646AbSCQH2a>; Sun, 17 Mar 2002 02:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311869AbSCQH2V>; Sun, 17 Mar 2002 02:28:21 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:43258 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S310646AbSCQH2E>; Sun, 17 Mar 2002 02:28:04 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sun, 17 Mar 2002 00:26:53 -0700
To: Theodore Tso <tytso@mit.edu>, David Rees <dbr@greenhydrant.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mke2fs (and mkreiserfs) core dumps
Message-ID: <20020317072653.GB1150@turbolinux.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020313123114.A11658@greenhydrant.com> <20020313205537.GC429@turbolinux.com> <20020313133748.A12472@greenhydrant.com> <20020313215420.GD429@turbolinux.com> <20020315182355.A1123@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315182355.A1123@thunk.org>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 15, 2002  18:23 -0500, Theodore Tso wrote:
> There's also the question
> whether or not filesize limits should really apply to device files,
> since the original point of filesize limits were as a simple-minded
> quota control mechanism, and there seems to be little point to causing
> attempts to access block deivces to fail --- under what circumstances
> would this *ever* be considered a useful thing?

Yes, I have always considered this a kernel bug (introduced in 2.4.10),
but my (admittedly feeble) attempts to get it fixed were not accepted.
At one point I thought a fix went into 2.4.18-pre[12] or so, but I
guess not.  I haven't tried in a while, so maybe I should make another
attempt.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

