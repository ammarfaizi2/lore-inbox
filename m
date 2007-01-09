Return-Path: <linux-kernel-owner+w=401wt.eu-S1751042AbXAIE3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXAIE3i (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 23:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbXAIE3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 23:29:38 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:37966 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbXAIE3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 23:29:38 -0500
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
In-Reply-To: <45A08269.4050504@zytor.com>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <20061216094421.416a271e.randy.dunlap@oracle.com>
	 <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com>
	 <1166297434.26330.34.camel@localhost.localdomain>
	 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
	 <1168140954.2153.1.camel@nigel.suspend2.net>  <45A08269.4050504@zytor.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 15:29:35 +1100
Message-Id: <1168316975.6948.2.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Sat, 2007-01-06 at 21:17 -0800, H. Peter Anvin wrote:
> Nigel Cunningham wrote:
> > On Tue, 2006-12-26 at 08:49 -0800, H. Peter Anvin wrote:
> >> The two things git users can do to help is:
> >>
> >> 1. Make sure your alternatives file is set up correctly;
> >> 2. Keep your trees packed and pruned, to keep the file count down.
> >>
> >> If you do this, the load imposed by a single git tree is fairly negible.
> > 
> > Sorry for the slow reply, and the ignorance... what's an alternatives
> > file? I've never heard of them before.
> > 
> 
> Just a minor correction; it's the "alternates" file 
> (objects/info/alternates).

I went looking for documentation on how to use the alternates feature,
and found an email from September 2005
(http://www.ussg.iu.edu/hypermail/linux/kernel/0509.1/2860.html) that
says:

<quote>
/pub/scm/linux/kernel/git/$u/$tree

Of course, you may have more than one such $tree. The
suggestion by Linus was to do (please do not do this yet -- that
is what this message is about):

$ cd /pub/scm/linux/kernel/git/$u/$tree
$ cat /pub/scm/linux/kernel/git/torvalds/linux-2.6/objects \
>objects/info/alternates
$ GIT_DIR=. git prune
</quote>

Are these instructions still correct in the case of master.kernel.org?

Regards,

Nigel

