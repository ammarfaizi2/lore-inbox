Return-Path: <linux-kernel-owner+w=401wt.eu-S932321AbWLLSHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWLLSHV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWLLSHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:07:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52036 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932321AbWLLSHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:07:19 -0500
Date: Tue, 12 Dec 2006 10:07:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.20
In-Reply-To: <PPamA8AW.1165944805.3983670.khali@localhost>
Message-ID: <Pine.LNX.4.64.0612120959110.3535@woody.osdl.org>
References: <PPamA8AW.1165944805.3983670.khali@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2006, Jean Delvare wrote:
> 
> Please pull the i2c subsystem updates for Linux 2.6.20 from branch
> i2c-for-linus of repository git://jdelvare.pck.nerim.net/jdelvare-2.6
> 
> There are 3 new i2c bus drivers, one old broken bus driver deleted, and a
> few cleanups and fixes in the i2c core and individual drivers.
> 
> I'm not yet comfortable with git so please let me know if I did anything
> wrong.

Looks fine. Your "please pull" message hass some slight stylistic 
problems, but the pull looks good, and matches what you claimed for it.

The stylistic problems are:

 - please write the git repo address and branch name on alone the same 
   line so that I can't even by mistake pull from the wrong branch, and so
   that a triple-click just selects the whole thing. 

   So the proper format is something along the lines of:

	"Please pull from

		git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

	 to get these changes:"

   so that I don't have to hunt-and-peck for the address and inevitably 
   get it wrong (actually, I've only gotten it wrong a few times, and 
   checking against the diffstat tells me when I get it wrong, but I'm 
   just a lot more comfortable when I don't have to "look for" the right 
   thing to pull, and double-check that I have the right branch-name)

 - your diffstat was fine, but was line-wrapped for some reason, which 
   just makes it harder for me to line up and compare against what I 
   actually got when pulling (ie I just have two xterms open, one with 
   the mail-reader, one with my shell command line, and I visually compare 
   what I get with what I _should_ get, and then something as silly as 
   incorrectly wrapped lines just makes the thing look visually different, 
   which again just throws me for all the wrong reasons).

But everything looks fine apart from those trivial details. Pulled and 
pushed out,

		Linus
