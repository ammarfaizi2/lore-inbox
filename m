Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbSJFEQP>; Sun, 6 Oct 2002 00:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263311AbSJFEQO>; Sun, 6 Oct 2002 00:16:14 -0400
Received: from f26.law8.hotmail.com ([216.33.241.26]:12553 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263298AbSJFEQN>;
	Sun, 6 Oct 2002 00:16:13 -0400
X-Originating-IP: [24.44.249.150]
From: "sean darcy" <seandarcy@hotmail.com>
To: rml@tech9.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 - no keyboard
Date: Sun, 06 Oct 2002 00:21:44 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F26l1GM3h3vLgAusVxO00010172@hotmail.com>
X-OriginalArrivalTime: 06 Oct 2002 04:21:45.0185 (UTC) FILETIME=[E1400D10:01C26CEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks. Worked like a charm. Of course then i had to fix psaux legacy to 
make XFree work - and then go back for ps/2 mice.

Obviously I wasn't paying enough attention to lkml to catch this change, but 
it certainly seems like a trap for the unwary - and even the somewhat wary. 
If I could help, I'd be happy to try to fix the config options to make all 
this clearer.

jay

>
> > I've built 2.5.40 on a rh8.0 athlon box.  It boots up OK, but NO 
>keyboard.
> >
>............
>You need to enable serio first.  Something like this:
>
>	CONFIG_SERIO=y
>	CONFIG_SERIO_I8042=y
>	CONFIG_KEYBOARD_ATKBD=y
>
>should work.
>
>	Robert Love




_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

