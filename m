Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267300AbTGTPem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 11:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbTGTPem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 11:34:42 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:50683 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S267300AbTGTPek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 11:34:40 -0400
Message-ID: <08be01c34ed6$702dbf40$64ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <Valdis.Kletnieks@vt.edu>
Cc: <linux-kernel@vger.kernel.org>
References: <081701c34ed0$5be60070$64ee4ca5@DIAMONDLX60> <200307201526.h6KFQs9K003972@turing-police.cc.vt.edu>
Subject: Re: Tried to run 2.6.0-test1 
Date: Mon, 21 Jul 2003 00:48:54 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu replied to me.  I'm sending this personally and to
the list.  Again I can't keep up with the list, so if Mr./Ms. Kletnieks or
anyone else has further advice or questions, please contact me directly.

>> What does the thing need in order to use modules?
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/people/rusty/modules/

550 /pub/linux/kernel/people/people/rusty/modules/: No such file or
directory

Oh I see, two many people.  After fixing that, I see a list of
module-init-tools. Hmm, modutils-2.4.21-18.src.rpm is indeed newer
than SuSE 8.1.  Downloading it now and will try it after sleeping.

I guess it's just luck that Red Hat 9 had a sufficiently new modutils.

> And read http://www.codemonkey.org.uk/post-halloween-2.5.txt for
> all the OTHER stuff you might need...

DNS error.

>> By the way there are also no tones from PCMCIA during the
>> boot process so I'm pretty sure it's also not recognizing my LAN card,
>
> The 'no tones' confused me too.  In 'make menuconfig', go to 'Input Device
> support', select 'Misc' - this will add an entry 'PC Speaker Support'.
> Check that, it will add  CONFIG_INPUT_PCSPKR which should make the beeps
> return.

I have it configured as a module.  I guess it will be fixed automatically
when modules start working.

> If you hit other snags, *read the post-halloween file*.  Most of the
> gotchas are in there already.

All except the DNS error, which came up again while I was checking out the
rest of this.  I don't think post-halloween will get here tonight.

