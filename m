Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWGaUHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWGaUHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWGaUHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:07:23 -0400
Received: from mail.gmx.net ([213.165.64.21]:36054 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932436AbWGaUHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:07:21 -0400
X-Authenticated: #428038
Date: Mon, 31 Jul 2006 22:07:18 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Adrian Ulrich <reiser4@blinkenlights.ch>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731200718.GA13257@merlin.emma.line.org>
Mail-Followup-To: Adrian Ulrich <reiser4@blinkenlights.ch>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731165406.GA8526@merlin.emma.line.org> <20060731195621.367ed702.reiser4@blinkenlights.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731195621.367ed702.reiser4@blinkenlights.ch>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Ulrich schrieb am 2006-07-31:

> Ehr: Such a migration (on a very busy system) takes *some* time (weeks).
> Re-Doing (migrate users back / recreate the FS / start again) the whole
> thing isn't really an option..

All the more important to think about FS requirements *before*
newfs-ing if a quick "one day for rsync/star/dump+restore" isn't
available. If you're hitting, for instance, the hash collision problem
in reiser3, you're as dead as with a FS without inodes.

> > > Have you ever seen VxFS or WAFL in action?
> > 
> > No I haven't. As long as they are commercial, it's not likely that I
> > will.
> 
> Why?

I'm trying to shift my focus away from computer administration and
better file systems than old-style non-journalling, non-softupdates UFS
are available today and more will follow.

Cc: list weeded out.

-- 
Matthias Andree
