Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbTL0WNY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 17:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTL0WNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 17:13:23 -0500
Received: from mail.aei.ca ([206.123.6.14]:9201 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S264855AbTL0WNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 17:13:21 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: Solution found: kernel-2.6.0/esd/realplayer8 doesn't work
Date: Sat, 27 Dec 2003 17:13:17 -0500
User-Agent: KMail/1.5.93
Cc: Tetsuji Rai <badtrans666@yahoo.co.jp>
References: <3FE8E39D.4090905@yahoo.co.jp>
In-Reply-To: <3FE8E39D.4090905@yahoo.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312271713.18596.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 23, 2003 07:53 pm, Tetsuji Rai wrote:
> Self reply and post as my reminder....
> use
>
> export LD_ASSUME_KERNEL=2.2.5
>
> and realplayer works fine.

This implies it might be a thread problem.  In my case, using 2.6.0-mm1, xine works
fine but xmms fails.  Its _not_ fixed here with the above export.

Ed Tomlinson

> -------- Original Message --------
> Subject: kernel-2.6.0/esd/realplayer8 doesn't work
> Date: Tue, 23 Dec 2003 23:21:13 +0900
> From: Tetsuji Rai <badtrans666@yahoo.co.jp>
> To: linux-kernel@vger.kernel.org
>
> Hi, all
>
>    I just installed kernel-2.6.0 release on debian-testing.   On my box esd
> works with xmms, mpg123 as with kernel-2.4.xx series, however, only
> Realplayer8 cannot use esd at all.  Realplayer says "cannot open audio
> device, Another application may be using it."  Sounds strange.   It works
> very fine with the very same configuration on kernel 2.4.23.
>    As a matter of course module-init-tools are installed for kernel-2.6.0.
> Strange thing is xmms, mpg123 works, but that realplayer doesn't work.  And
> when some weeks ago I tested kernel 2.6.0-test6/7, realplayer worked as
> expected.
>   Will anybody have any idea?   I once suspect it should be related to
> connection between realplayer and esd, but if so kernel version doesn't
> matter.   So there should be another reason;for eg. esound doesn't keep up
> with kernel development...just a guess.
>
> PS: I recompiled esound daemon 0.2.32 with kernel 2.6.0 for sure.
>
> TIA
> --
> Tetsuji Rai (in Tokyo) aka AF-One (Athlete's Foot-One)
> Born to be the luckiest guy in the world!   May the Force be with me!
> http://www.geocities.com/tetsuji_rai
> http://setiathome.ssl.berkeley.edu/fcgi-bin/fcgi?cmd=view_feedback&id=1855
> fax: 1-516-706-0320
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
