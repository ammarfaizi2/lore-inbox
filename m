Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314650AbSD1AeJ>; Sat, 27 Apr 2002 20:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314651AbSD1AeI>; Sat, 27 Apr 2002 20:34:08 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:51724 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314650AbSD1AeI>;
	Sat, 27 Apr 2002 20:34:08 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Richard Thrapp <rthrapp@sbcglobal.net>
Cc: Francois Romieu <romieu@cogenit.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The tainted message 
In-Reply-To: Your message of "27 Apr 2002 10:51:52 EST."
             <1019922717.8819.62.camel@wizard> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Apr 2002 10:33:56 +1000
Message-ID: <31492.1019954036@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Apr 2002 10:51:52 -0500, 
Richard Thrapp <rthrapp@sbcglobal.net> wrote:
>On Sat, 2002-04-27 at 07:08, Francois Romieu wrote:
>> Richard Thrapp <rthrapp@sbcglobal.net> :
>> [...]
>> > First of all, the current tainted message is not really useful. 
>> > "Warning: Loading %s will taint the kernel..." isn't very informative at
>> > all.  Most people don't know what it means to "taint the  kernel".  It's
>> 
>> Add a reference to http://www.tux.org/lkml/#s1-18. An explanation is already
>> there.
>
>That doesn't fix the problem.  The message is still wrong.  A reference
>to an explanation only helps the people who can reach it immediately. 
>Linux is also used on manufacturing floors (and several other places)
>where no network connections exist.

Those people can modify and ship a version of modutils that does not
issue the taint message.  That makes it their problem, not ours.  I
know of at least one embedded system distributer who is doing just
this.

If you want to ship binary only modules and you don't want your users
to question this, removal of the warning messages is your problem.  GPL
allows anybody to change any messages they like as long as they supply
the changed source.  I will not (cannot) stop people changing modutils
to defeat community expectations but I will not support them either.

