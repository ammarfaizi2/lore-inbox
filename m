Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263340AbRFADiw>; Thu, 31 May 2001 23:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263341AbRFADim>; Thu, 31 May 2001 23:38:42 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:33426 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S263340AbRFADib>; Thu, 31 May 2001 23:38:31 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "D. Stimits" <stimits@idcomm.com>
Subject: Re: missing sysrq
Date: Fri, 1 Jun 2001 05:51:31 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010601033839Z263340-932+3417@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> D. Stimits wrote:
>
> > Bernd Eckenfels wrote:
> > > 
> > In article <3B15EF16.89B18D@idcomm.com> you wrote:
> > > However, if I go to /proc/sys/kernel/sysrq does not exist.
> > 
> > It is a compile time option, so the person who compiled your kernel
> > left it out.
>
> I compiled it, and the sysrq is definitely in the config. No doubt at
> all. I also use make mrproper and config again before dep and actual
> compile. Maybe it is just a quirk/oddball.
>
> D. Stimits, stimits@idcomm.com

Have you tried "echo 1 > /proc/sys/kernel/sysrq"?
You need both, compiled in and activation.

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
