Return-Path: <linux-kernel-owner+w=401wt.eu-S932631AbWLMJYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932631AbWLMJYG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWLMJYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:24:06 -0500
Received: from zone4.gcu.info ([217.195.17.234]:51211 "EHLO
	zone4.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932635AbWLMJYF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:24:05 -0500
Date: Wed, 13 Dec 2006 09:53:32 +0100 (CET)
To: torvalds@osdl.org
Subject: Re: [GIT PULL] i2c updates for 2.6.20
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <UtoUGJup.1166000012.4391950.khali@localhost>
In-Reply-To: <Pine.LNX.4.64.0612120959110.3535@woody.osdl.org>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

On 12/12/2006, Linus Torvalds wrote:
> On Tue, 12 Dec 2006, Jean Delvare wrote:
> > Please pull the i2c subsystem updates for Linux 2.6.20 from branch
> > i2c-for-linus of repository git://jdelvare.pck.nerim.net/jdelvare-2.6
> >
> > There are 3 new i2c bus drivers, one old broken bus driver deleted, and a
> > few cleanups and fixes in the i2c core and individual drivers.
> >
> > I'm not yet comfortable with git so please let me know if I did anything
> > wrong.
>
> Looks fine. Your "please pull" message hass some slight stylistic
> problems, but the pull looks good, and matches what you claimed for it.
>
> The stylistic problems are:
>
>  - please write the git repo address and branch name on alone the same
>    line so that I can't even by mistake pull from the wrong branch, and
>    so that a triple-click just selects the whole thing.
>
>    So the proper format is something along the lines of:
>
> 	"Please pull from
>
> 		git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus
>
> 	 to get these changes:"
>
>    so that I don't have to hunt-and-peck for the address and inevitably
>    get it wrong (actually, I've only gotten it wrong a few times, and
>    checking against the diffstat tells me when I get it wrong, but I'm
>    just a lot more comfortable when I don't have to "look for" the right
>    thing to pull, and double-check that I have the right branch-name)

OK, should be easy enough to fix :)

>  - your diffstat was fine, but was line-wrapped for some reason, which
>    just makes it harder for me to line up and compare against what I
>    actually got when pulling (ie I just have two xterms open, one with
>    the mail-reader, one with my shell command line, and I visually compare
>    what I get with what I _should_ get, and then something as silly as
>    incorrectly wrapped lines just makes the thing look visually different,
>    which again just throws me for all the wrong reasons).

Sorry about that, I'm currently working from a remote location so I have
to rely on a webmail to post, and that webmail doesn't give me as much
control as I'd like on formatting. I tried to shorten the long bars and
hoped it wouldn't wrap, but it seems it did still. This should not
happen otherwise (when I'm at home.) In the meantime, I will instruct
diffstat to produce a 72-column output so that no wrapping can occur.

> But everything looks fine apart from those trivial details. Pulled and
> pushed out,

Great, thanks :) hwmon is coming next.

--
Jean Delvare
