Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTLDBrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTLDBrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:47:52 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:60053 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262991AbTLDBru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:47:50 -0500
Date: Wed, 3 Dec 2003 17:47:43 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031204014743.GF29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
References: <20031202135423.GB13388@conectiva.com.br> <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz> <bql9kk$iq1$1@gatekeeper.tmr.com> <20031204012420.GE4420@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204012420.GE4420@pegasys.ws>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 05:24:20PM -0800, jw schultz wrote:
> <OT>
> As a datapoint i'm running ext2, reiserfs, JFS and XFS each
> for different reasons.
> 
> 	ext2 -- boot (i'm stodgy) and 2kb blocks for archive CDs
> 
> 	reiserfs3 -- filesystems not exported nfs (no
> 	historical version level that i can confirm whether
> 	i have or not will namesys assert is reliable over
> 	nfs)
> 

Maybe you should just try it?  I've used reiserfs on an NFS/samba server,
and it didn't give me trouble.

> 	jfs -- most nfs exported filesystems, decent
> 	performance and solid but i don't use if for home
> 	because in SuSE's 2.4.18 (i know it is ancient but
> 	solid for me) jfs doesn't update mtime of
> 	directories unless the block allocation changes
> 	breaking maildir update detection.

This has been fixed in newer versions of JFS though, right?

> 	xfs -- home (because of the jfs bug) Earlier tests
> 	of xfs gave me horrible performance and i haven't
> 	gotten around to testing since then.  If this is
> 	fixed without tuning i might drop jfs.  Then again i
> 	may drop xfs in the next upgrade if i change distros
> 	and xfs isn't in-kernel.

What about ext3?  I tend to prefer ext3 since I know how it works more than
the others, and it puts data integrity ahead of performance, which is the
way things should be (TM).

