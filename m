Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSEYTQp>; Sat, 25 May 2002 15:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315258AbSEYTQo>; Sat, 25 May 2002 15:16:44 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:28427 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S315257AbSEYTQn>; Sat, 25 May 2002 15:16:43 -0400
Message-ID: <3CEFE2A0.18166785@opersys.com>
Date: Sat, 25 May 2002 15:14:40 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Wolfgang Denk <wd@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205251138390.17649-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
>  "..every single spinlock in the kernel assumes that the kernel isn't
>   preempted, which means that user apps that can preempt the kernel
>   cannot use them."

I misread this paragraph, the rest of my reply follows from this laps.

I said there was no "priority inversion" in the sense that there are
no priority inversion problems during the execution of such user-space
rt tasks. From a purely static perspective, however, the user-space
rt tasks do indeed come to have a higher priority than the kernel.
No fuss there.

That being said, I differ on your judgement of this method.

Karim 

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
