Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264238AbRFMWOQ>; Wed, 13 Jun 2001 18:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264284AbRFMWNz>; Wed, 13 Jun 2001 18:13:55 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:32157 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S264238AbRFMWNq>; Wed, 13 Jun 2001 18:13:46 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Changing CPU Speed while running Linux
Date: Thu, 14 Jun 2001 00:23:07 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ACPI List <acpi@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010613221355Z264238-17720+3532@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
> Sven Geggus wrote:
> >
> > Hi there,
> >
> > on my Elan410 based System it is very easy to change the CPU clock
> > speed by means od two outb commands.
> >
> > I was wondering, if it does some harm to the Kernel if the CPU is
> > reprogrammed using a different CPU clock speed, while the system is up and
> > running.
>
> I have a module for the K6 PowerNow which allows you to do
>
> echo 450 > /proc/sys/cpu/0/frequency
>
> and does the right thing wrt udelay / bogomips etc..
> I can dig it out if you want.. sounds like this should be a more generic
> thing.

Yes, please.

After (all) Athlon 4/MT (Palomino)  and Duron mobile feature PowerNow! it 
should be usefull for more and more people.

Regards,
	Dieter

BTW	I think there are only a "few" K6-2+/K6-III+ out ;-)
	But PowerNow! is nice stuff. I had an eye on an 1 GHz Palomino
	at CeBIT '2001.
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
