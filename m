Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRJUVEA>; Sun, 21 Oct 2001 17:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276753AbRJUVDu>; Sun, 21 Oct 2001 17:03:50 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:49033 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S276743AbRJUVDh>; Sun, 21 Oct 2001 17:03:37 -0400
Content-Type: text/plain;
  charset="iso-8859-2"
From: Tim Jansen <tim@tjansen.de>
To: lgb@lgb.hu
Subject: LPP (was: The new X-Kernel !)
Date: Sun, 21 Oct 2001 23:06:29 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya> <20011022013747.I5511@higherplane.net> <20011021220346.D19390@vega.digitel2002.hu>
In-Reply-To: <20011021220346.D19390@vega.digitel2002.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <15vPl5-14xxS4C@fmrl02.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 22:03, Gábor Lénárt wrote:
> Errrm ;-) It's very bad thing to hide boot messages even for novice users.
> They can't bugreport in this way ... 

You can switch to the regular console using some key. You probably don't want 
bug reports from users who can't even do this, so basically it's a filter :)

> messages should remain IMHO. But this bar indicator confuses me. How do you
> calculate the remaining percentage? And of course this is kernel boot only.
> After init, you can start costum process to show an indicator bar to
> messure remaining tasks before hitting xdm/kdm/gdm/login/whatever.

No, the LPP screen remains until X starts. You set the progress by writing to 
a file called /proc/progress. So there is a patch (at least for debian) that 
changes the init scripts to report the progress of booting. You can easily 
calculate the percentage when you count the scripts in /etc/rcX that you have 
to start.

bye...
