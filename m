Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbVD2Wmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbVD2Wmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVD2Wmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:42:45 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:25400
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S263043AbVD2Wmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:42:33 -0400
Date: Sat, 30 Apr 2005 00:47:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Olivier Galibert <galibert@pobox.com>, Sean <seanlkml@sympatico.ca>,
       Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050429224742.GN17379@opteron.random>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1> <20050429201957.GJ17379@opteron.random> <20050429223052.GD28540@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429223052.GD28540@dspnet.fr.eu.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 12:30:52AM +0200, Olivier Galibert wrote:
> Nothing a little caching can't solve.  Given that git's objects are
> immutable caching is especially easy to do, you can have the delta
> reference indexes in the filename.

Rather than creating delta reference indexes we can as well use
mercurial that uses them as primary storage.

git is the _storage_ filesystem, if we can't use it but we've to create
another different representation to do efficient network download, we
can as well the more efficient representation instead of git, that's
what mercurial does AFIK.
