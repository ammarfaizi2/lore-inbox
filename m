Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268981AbRHLHpJ>; Sun, 12 Aug 2001 03:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268992AbRHLHo7>; Sun, 12 Aug 2001 03:44:59 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:38162 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268981AbRHLHor>;
	Sun, 12 Aug 2001 03:44:47 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Your message of "Sun, 12 Aug 2001 09:31:40 +0200."
             <20010812093140.A820@jaquet.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 17:44:48 +1000
Message-ID: <10614.997602288@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001 09:31:40 +0200, 
Rasmus Andersen <rasmus@jaquet.dk> wrote:
>On Sun, Aug 12, 2001 at 12:11:27PM +1000, Keith Owens wrote:
>[...] 
>> >pp_makefile2: Cannot find source for target drivers/sound/emu10k1/efxmgr.o
>> >pp_makefile2: Cannot find source for target drivers/sound/emu10k1/joystick.o
>> >pp_makefile2: Cannot find source for target drivers/sound/emu10k1/passthrough.o
>> 
>> You put kbuild-2.5-2.4.8-1 on an 2.4.8-pre kernel.  Linus moved emu10k1
>> to its own directory in 2.4.8.  You have match kbuild with the correct
>> kernel.
>
>Yes, I have to and no, I did not. It was kbuild-2.5-2.4.8-1 on a
>freshly untarred 248.tar.gz from a mirror. But kbuild-...-2 fixes
>it for me fine.

Very strange, drivers/sound/emu10k1/efxmgr.c is definitely in 2.4.8 but
not in 2.4.8-pre.  The corrected emu10k1 list in kbuild-2.5-2.4.8-2
added even more objects, but did not remove references to efxmgr.  I
still think it was a bad source tree problem.  Oh well, it is "fixed" now.

