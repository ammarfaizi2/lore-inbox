Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbQKJK0Y>; Fri, 10 Nov 2000 05:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQKJK0O>; Fri, 10 Nov 2000 05:26:14 -0500
Received: from pop08-1-ras1-p27.barak.net.il ([212.150.109.27]:16388 "EHLO
	champ.linuxnet.org.il") by vger.kernel.org with ESMTP
	id <S129249AbQKJK0C>; Fri, 10 Nov 2000 05:26:02 -0500
Message-ID: <3A0BCB67.2EDE5825@xpert.com>
Date: Fri, 10 Nov 2000 12:18:15 +0200
From: Constantine Gavrilov <const-g@xpert.com>
Reply-To: Constantine Gavrilov <const-g@xpert.com>
Organization: Xpert
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.16pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: willy tarreau <wtarreau@yahoo.fr>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <20001110092846.29847.qmail@web1102.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

willy tarreau wrote:
> 
> > Anything which isnt a strict bug fix or previously
> > agreed is now 2.2.19 material.
> 
> Alan, do you consider it as a bugfix if I tell you
> that
> we can't get anymore oops with the new bonding code,
> even in SMP ?
> 
> I've had reports of it working very well, and faster,
> for a long time now and the link detection seems
> completely OK now. I'd like to specially thank
> Constantine Gavrilov for all the tests he has done and
> the time he spent in enhancing the documentation.
> 
> Please find the patch against 2.2.18pre20 in
> attachment, in case you agree.
> 
> Regards,
> Willy

I do think the new code is much better. Anyone who is considering using trunking
for their projects should use the new code since it has link monitoring and
active backup mode. However, I am a maniac when it comes to kernel testing. If I
say it really works, it usually works. This code has been tested much and bugs
were fixed. However, it has not been tested enough that I may bet by head on
saying there are no known issues. This is because I did not have access to all
hardware that was needed to complete the tests in time.

The code is not worse than the old code. However, a clear note must be made that
this is experimental code and probably has small issues. So if it is included,
it must me marked as experimental.


----------------------------------------
Constantine Gavrilov
Unix System Administrator and Programmer
Xpert Integrated Systems
1 Shenkar St, Herzliya 46725, Israel
Phone: (972-8)-952-2361
Fax:   (972-9)-952-2366
----------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
