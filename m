Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269489AbUI3U3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269489AbUI3U3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269502AbUI3U3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:29:39 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:26034 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S269489AbUI3U1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:27:22 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
Date: Thu, 30 Sep 2004 16:27:20 -0400
User-Agent: KMail/1.7
Cc: Clemens Schwaighofer <cs@tequila.co.jp>,
       "Markus T." <markus@trippelsdorf.net>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <200409300102.07373.gene.heskett@verizon.net> <415BA7D0.7070704@tequila.co.jp>
In-Reply-To: <415BA7D0.7070704@tequila.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409301627.20548.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.8.60] at Thu, 30 Sep 2004 15:27:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 02:29, Clemens Schwaighofer wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>On 09/30/2004 02:02 PM, Gene Heskett wrote:
>| On Thursday 30 September 2004 00:53, Markus T. wrote:
>|># bzcat patch-2.6.9-rc3.bz2 | patch -p1
>|>...
>|>patching file fs/nfs/file.c
>|>Hunk #2 FAILED at 74.
>|>Hunk #3 FAILED at 91.
>|>2 out of 11 hunks FAILED -- saving rejects to file
>|> fs/nfs/file.c.rej ...
>|>
>|>___
>|>Markus
>|
>| And thats one of the reasons I never dl the bz2 version.
>
>what has bz2 to do with that?

bz2 has resulted in corrupted unpacks here on more than one occasion, 
and it has done it without any outwardly visible error when the 
md5sum was good.  I've had it skip a whole subdir tree in a kernel 
unpack on at least 4 occasions, and a missing file someplace on 
several more occasions.  I don't have any such troubles when dl'ing 
and using the .gz version of things.

There has been at least one occasion where the .bz2 dl had a bad 
md5sum, again without any visible error as it was downloading, nuke 
it and go back and get the same file again and it was good.  Again 
I've had no such troubles when using the .gz versions, so after a a 
while, I got into the habit of just gettng the .gz version and I've 
never had an instance of a bad md5sum that wasn't accompanied by site 
access problems.

>| You should have started with a fresh unpack of 2.6.8, not 2.6.8.1
>| I just checked my scrollback and there is no such error here.
>
>well its a bit confusing. 2.6.8.1 is the latest stable right,
> normaly patches are applied against the latest stable.

There was a discussion about that here on the lkml, and linus's 
decision was to reference all further patches against 2.6.8.  Its 
broken, but its the anchor point till 2.6.9 comes out.

> Let's just  hope this NFS fix is on the rc series if you have to 
> apply against 2.6.8
>
Other than amdump made a half fubar'd backup last night using -rc3, 
its running reasonably well here.  If the amdump bombs again tonight, 
then we get out the magnifying glass & start looking.  But first I'd 
have to know where to start & there are no odd entries in the log for 
that time of the morning.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
