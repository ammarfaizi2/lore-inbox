Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWGXQSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWGXQSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWGXQSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:18:04 -0400
Received: from thunk.org ([69.25.196.29]:6553 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751213AbWGXQSD (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:18:03 -0400
Date: Mon, 24 Jul 2006 12:17:55 -0400
From: Theodore Tso <tytso@mit.edu>
To: Olivier Galibert <galibert@pobox.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060724161755.GA3317@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Olivier Galibert <galibert@pobox.com>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Nikita Danilov <nikita@clusterfs.com>, Steve Lord <lord@xfs.org>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C42B92.40507@xfs.org> <17604.31844.765717.375423@gargle.gargle.HOWL> <20060724103023.GA7615@thunk.org> <20060724113534.GA64920@dspnet.fr.eu.org> <20060724133939.GA11353@thunk.org> <20060724153853.GA88678@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724153853.GA88678@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 05:38:53PM +0200, Olivier Galibert wrote:
> I'm no talking about extends only.  Ext3 now is very, very different
> than the ext2+journal it was at the start, with backwards-incompatible
> format changes added all the time[1].  These changes went in
> no-questions-asked.

The patches indeed were reviewed and changes made in response to the
reviews.  The philosophical/design question about whether or not
optional features which, if enabled, would prevent older kernels to
mount the filesystem was not asked, no.  But that doesn't mean that
the code was not reviewed; it was.

I would also note that we didn't intimate that we knew better than the
reviewers, or question their motives, or otherwise insult the
reviewers such that they might decide they have better things to do
than to review our patches, and that might have had something to do
with how the code got in relatively painlessly....

						- Ted
