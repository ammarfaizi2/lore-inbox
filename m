Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbRFAWoh>; Fri, 1 Jun 2001 18:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbRFAWo0>; Fri, 1 Jun 2001 18:44:26 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.159.219.15]:44422 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S261719AbRFAWoU>; Fri, 1 Jun 2001 18:44:20 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: george anzinger <george@mvista.com>
Subject: Re: missing sysrq
Date: Sat, 2 Jun 2001 00:58:52 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10106011050380.2614-100000@coffee.psychology.mcmaster.ca> <20010601203841Z261493-933+3160@vger.kernel.org> <3B1817DD.48A91CB8@mvista.com>
In-Reply-To: <3B1817DD.48A91CB8@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010601224421Z261719-933+3177@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 2. Juni 2001 00:31 schrieb george anzinger:
> Dieter Nützel wrote:
> > Am Freitag, 1. Juni 2001 16:51 schrieben Sie:
> > > > Have you tried "echo 1 > /proc/sys/kernel/sysrq"?
> > > > You need both, compiled in and activation.
> > >
> > > no, look at the code.  the enable variable defaults to 1.
> >
> > Then there must be a bug?
> > I get "0" with 2.4.5-ac2 and -ac5 without "echo 1".
> >
> > Fresh booted 2.4.5-ac2:
>
> Bet not!  Most distro scripts turn it off on the way up.  Sometimes it
> is a bit hard to find where they do it too.
>

Good point!

Easy for SuSE 7.1/7.2 (?).

SunWave1#grep SYSRQ /etc/rc.config
ENABLE_SYSRQ="no"

Thanks,
	Dieter
