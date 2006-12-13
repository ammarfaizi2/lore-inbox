Return-Path: <linux-kernel-owner+w=401wt.eu-S932597AbWLME6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWLME6p (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 23:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWLME6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 23:58:45 -0500
Received: from pqueueb.post.tele.dk ([193.162.153.10]:35985 "EHLO
	pqueueb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbWLME6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 23:58:42 -0500
X-Greylist: delayed 1069 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 23:58:41 EST
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
From: Kasper Sandberg <lkml@metanurb.dk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: vojtech@suse.cz, ak@muc.de, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
In-Reply-To: <200612110330_MC3-1-D49B-BC0E@compuserve.com>
References: <200612110330_MC3-1-D49B-BC0E@compuserve.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 05:39:43 +0100
Message-Id: <1165984783.23819.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 03:27 -0500, Chuck Ebbert wrote:
> In-Reply-To: <1165409880.15706.9.camel@localhost>
> 
> On Wed, 06 Dec 2006 13:58:00 +0100, Kasper Sandberg wrote:
> 
> > > Kasper, what problems (other that the annoying message) are you having?
> > if it had only been the messages i wouldnt have complained.
> > the thing is, when i get these messages, the app provoking them acts
> > very strange, and in some cases, my system simply hardlocks.
> 
> You can try the patch I sent you to see if it fixes the Wine app.
> (David thought I was proposing it for the mainline kernel but I just
> wanted to see whether it made a difference.)

do you think it may be a bug in the kernel? the stuff with wine that
gets thrown in the kernel messages? cause if it is, i ofcourse wish to
help by testing. one more thing, im 100% positive wine does NOT have
access to any fat32, cause i entirely removed the only disk having such
a filesystem, and it still likes to give this, however the last few
times i havent observed the app going nuts :)

> 
> As for the lockups, there are possibly other bugs lurking in 2.6.19.
yes, when the using-much-ram-perhaps-even-swap thing was mentioned i
came to think, cause i do happen to use alarmingly much swap. i noticed
a ~5 second lockup (where it actually returned to normal again) when i
reached ~50mb free ram, and this was outside the chroot.


> 

