Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265439AbRGLW06>; Thu, 12 Jul 2001 18:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbRGLW0s>; Thu, 12 Jul 2001 18:26:48 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:5388 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265439AbRGLW0b>; Thu, 12 Jul 2001 18:26:31 -0400
Message-Id: <200107122226.f6CMQVU64270@aslan.scsiguy.com>
To: Luc Lalonde <llalonde@giref.ulaval.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec SCSI driver lockups 
In-Reply-To: Your message of "Thu, 12 Jul 2001 17:54:11 EDT."
             <3B4E1C83.D4E1E738@giref.ulaval.ca> 
Date: Thu, 12 Jul 2001 16:26:31 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello Justin and Alan,
>
>There was some garbage printed to the /var/log/messages before the
>lockup but it is unreadable.

It may have been corrupted by the hang/crash.  This is why using
a serial console is *always* the best bet for tracking down these
kinds of issues.

>If I use the append="aic7xxx=verbose"
>in my lilo.conf will it log extra messages in /var/log/messages?

The messages are printed to the console and, if syslogd is running,
will be recorded in /var/log/messages.  However, there is always
a delay between the error being printed and syslogd getting that
text to disk.  A serial console doesn't have this problem.

>If so,
>will it be useful enough to figure out what the problem is?

I'll let you know when I see the messages. ;-)

--
Justin
