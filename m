Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312861AbSDBQ64>; Tue, 2 Apr 2002 11:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312859AbSDBQ6h>; Tue, 2 Apr 2002 11:58:37 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:55287 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312855AbSDBQ6Z>; Tue, 2 Apr 2002 11:58:25 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 2 Apr 2002 09:56:54 -0700
To: Ken Brownfield <ken@irridia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of quotas on ext3 and reiser?
Message-ID: <20020402165654.GC4735@turbolinux.com>
Mail-Followup-To: Ken Brownfield <ken@irridia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020401211410.A9161@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 01, 2002  21:14 -0600, Ken Brownfield wrote:
> But I also need quotas.  I've noticed that quotas do not appear to be
> supported by ext3, but I haven't tried reiser yet.  And I'm not sure
> if I simply need new quota userspace tools -- the ones I found were 1994
> vintage.  I'm on RH6.2 BTW for this case, and the builtin tools don't
> appear to grok ext3.

That is only because the old quota tools check for "ext2" as the
filesystem type, otherwise they do not activate quotas for that fs.

There are new quota tools at Sourceforge (don't know the project name).

> What is the current viability of quotas on ext3/reiser in a
> conservative, production environment?  Is it waiting for the 32-bit UID
> mods in 2.4.x, or has quota support been pushed off onto 2.5?

If you have a RH kernel (or any other -ac kernel) you will get 32-bit
UID support for quotas.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

