Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbTL3FWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 00:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265518AbTL3FWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 00:22:09 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:48535 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265517AbTL3FWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 00:22:03 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Subject: Re: 2.6.0-mm2
Date: Tue, 30 Dec 2003 00:21:57 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031229013223.75c531ed.akpm@osdl.org> <200312292315.08854.dtor_core@ameritech.net> <Pine.LNX.4.58.0312300454120.7711@student.dei.uc.pt>
In-Reply-To: <Pine.LNX.4.58.0312300454120.7711@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312300021.57227.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 December 2003 12:03 am, Marcos D. Marado Torres wrote:

> First of all, thanks for the help, my problem is now solved, and it's

Glad to hear it!

> good to see the patch you sent so used just have to pass
> psmouse_proto=... to the kernel whenever they compiled it as a module
> or built-in in the kernel. However the question is still there... I
> mean: I now know the sollution because I asked here on lkml, and now I
> understand what's really happening, but if the target is to get the
> work easy for those upgrading from 2.4, then you're failing... I mean,
> for those who are in the same sittuation than me they will just stop
> having the mouse tap feature with the kernel update, so why don't just
> make the psmouse_proto={bare|imps|exps} argument selectable in the
> kernel configuration?

I might consider expanding psmouse help section a bit but I somewhat
concerned that it will not have much exposure. 

>
> Once again, maybe there's something more that I can't see here, but
> makes pretty much more sense to me people have to do the choice while
> compiling the kernel than having no choice and then having to pass an
> argument to the kernel...

So a distribution for example does not have to supply bazillion kernel
versions to satisfy everyone.

BTW, are you opposed to having special driver or you just didn't have
time to try it out?

Dmitry
