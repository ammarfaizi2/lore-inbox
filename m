Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSEZALc>; Sat, 25 May 2002 20:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315476AbSEZALc>; Sat, 25 May 2002 20:11:32 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:22041 "EHLO
	tsmtp6.mail.isp") by vger.kernel.org with ESMTP id <S315472AbSEZALa>;
	Sat, 25 May 2002 20:11:30 -0400
Date: Sun, 26 May 2002 02:11:31 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: fchabaud@free.fr
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, pavel@ucw.cz
Subject: Re: 2.5.18, pdflush 100% cpu utilization
Message-Id: <20020526021131.5c8307e8.DiegoCG@teleline.es>
In-Reply-To: <200205252052.g4PKqs103253@colombe.home.perso>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2002 22:52:51 +0200 (CEST)
fchabaud@free.fr escribió:
> It probably has. I don't know what pdflush is but it has to be
> suspended using refrigerator(PF_IOTHREAD) because otherwise signals
> are not treated by this task and not resetted by suspend (hence the
> task has always signal pending after resume). 

Oh, yes, it has. I've re-tested, and system is good until i try to
suspend.

when i try to suspend, then suddenly pdflush gets all the cpu. Ths can
be funny because i've an cyrix (by ibm) 6x86MX, and it uses to give
problems when running at 100% because of hot ;)


Diego Calleja
