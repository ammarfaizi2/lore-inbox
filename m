Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUI3HcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUI3HcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 03:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268537AbUI3HcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 03:32:00 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:49107 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S267720AbUI3Hb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 03:31:56 -0400
Message-ID: <415BB625.9000403@andrew.cmu.edu>
Date: Thu, 30 Sep 2004 03:30:45 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clemens Schwaighofer <cs@tequila.co.jp>
CC: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       "Markus T." <markus@trippelsdorf.net>
Subject: Re: Linux 2.6.9-rc3
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <pan.2004.09.30.04.53.05.120184@trippelsdorf.net> <200409300102.07373.gene.heskett@verizon.net> <415BA7D0.7070704@tequila.co.jp>
In-Reply-To: <415BA7D0.7070704@tequila.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer wrote:

> | And thats one of the reasons I never dl the bz2 version.
>
> what has bz2 to do with that?

Some people believe bz2 to be buggy or otherwise less tolerant of 
corruption.  For most people these things don't seem to come up; I've 
never had problems with either despite frequent work with large 
compressed datasets.

> | You should have started with a fresh unpack of 2.6.8, not 2.6.8.1
> | I just checked my scrollback and there is no such error here.
>
> well its a bit confusing. 2.6.8.1 is the latest stable right, normaly
> patches are applied against the latest stable. Let's just hope this NFS
> fix is on the rc series if you have to apply against 2.6.8

Linus decided that patches will always be off the previous 
non-extraversion tarball.  Note that -rc3 is not relative to -rc2, so in 
that way its consistent.  The reason Linus gave is that such 
trivial-but-important bugfixes may come *after* the next version has 
releases or release cantidates, so this is the only sane way.  For 
example, if another tiny code bug motivated making a 2.6.8.2, the 
release cantidates shouldn't have to be rediffed.  Hopefully it makes 
sense now :)

 - Jim Bruce

