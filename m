Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132643AbRDKQwB>; Wed, 11 Apr 2001 12:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132651AbRDKQvv>; Wed, 11 Apr 2001 12:51:51 -0400
Received: from mx3.port.ru ([194.67.23.37]:31504 "EHLO smtp3.port.ru")
	by vger.kernel.org with ESMTP id <S132643AbRDKQvl>;
	Wed, 11 Apr 2001 12:51:41 -0400
From: info <5740@mail.ru>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: 2.4.3 compile error No 3
Date: Wed, 11 Apr 2001 20:34:26 +0400
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, John Jasen <jjasen@datafoundation.com>
In-Reply-To: <4AC3B9077C6@vcnet.vc.cvut.cz>
In-Reply-To: <4AC3B9077C6@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Message-Id: <01041120540000.05702@sh.lc>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Чтв, 12 Апр 2001, в сообщении на тему "Re: 2.4.3 compile error No 3", Petr Vandrovec написал:
> On 11 Apr 01 at 20:15, info wrote:
> > 
> > By the way, I thung that it is a good idea - to modify
> > xconfig/meniconfig script  in manner to make disable ipx if sysctl
> > setted off - like in many other cross-dependance options. 
> 
> Without sysctl you cannot disable Netbios propagation packet routing.
> And no machine with enabled Netbios routing passes our 'you must not
> participate in broadcast storms' test if it has enabled more than
> one IPX frame on each interface. So you'll get disconnected from our 
> university net.
>                                     Petr Vandrovec
>                                     vandrove@vc.cvut.cz

Sorry, Petr, I can't understand your mind: my knowlege in programming
and English isn't enougth.

My user's mind was: if sysctl is needed for ipx, then:
1-st variant -  to modify config script in such manner that sysctl
turned on automatically (maybe as other needable functions, if they
are) if ipx selected. 
2-nd variant - to modify it in such manner that you can't select ipx
before you select sysctl 

The second variant is more easy (for example: you can't select reiserfs now
if you doesn't select one of another option, I don't remember it's
name).
But  the first way is more user-friendly. This is the same principle
as in rpm during installation. For example: when I select in Mandrake
installer that I want to have Klyx in my KDE, the installer
automatically select tetex, latex, ghostscript and other packages.
Because klyx can't work without them. It is very  comfortable for
user.

I think that you, as kernel programmer, work with .config
directly. But  I - as user - work only on level of "menu xconfig"
screen when I try to compile.

I speake only about user's friendlyness of kernel config screen, not
about frames and other programming topics. I don't know what is it at
all. It is not my user's level.
