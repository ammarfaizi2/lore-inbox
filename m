Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWGXLff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWGXLff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 07:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWGXLff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 07:35:35 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:45069 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932117AbWGXLff (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 07:35:35 -0400
Date: Mon, 24 Jul 2006 13:35:34 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, Nikita Danilov <nikita@clusterfs.com>,
       Steve Lord <lord@xfs.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060724113534.GA64920@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Theodore Tso <tytso@mit.edu>, Nikita Danilov <nikita@clusterfs.com>,
	Steve Lord <lord@xfs.org>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL> <20060724103023.GA7615@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724103023.GA7615@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 06:30:23AM -0400, Theodore Tso wrote:
> (I mean geez, if you want really high standards before new code is
> accepted, take a look at Open Solaris; they have *such* a heavyweight
> process, with two mandatory signoffs by core Solaris engineers who
> both have to do a line-by-line review, and with a promise of on-disk
> and ABI compatibility *forever* ---- that we do more commits in a week
> than they do in a year....)

That sounds almost like gcc, only worse.

I think there is something of a problem currently, tough.  It is
getting too hard to get code in if you're not a maintainer for an
existing subsystem (reiser4, suspend2...), and too easy when you're a
maintainer (ext4, uswsusp...).  Ext patches don't get reviewed much
outside of the developpers, and they go in pretty much without
discussion in any case, except when Linus blows a fuse.  Reiser4 would
have be in without discussion if it had been a set of patches through
time to reiser3, and would have been called 4 only when Linus yelled.
I suspect some balancing would be useful.

  OG.

