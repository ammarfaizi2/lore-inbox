Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314095AbSDZRq1>; Fri, 26 Apr 2002 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314097AbSDZRq0>; Fri, 26 Apr 2002 13:46:26 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:50362 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S314095AbSDZRqZ>; Fri, 26 Apr 2002 13:46:25 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Subject: Re: Kernel 2.4.18 and strange OOM Killer behaveness
Date: Fri, 26 Apr 2002 19:46:14 +0200
X-Mailer: KMail [version 1.4]
Cc: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204261946.14955.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:

> Apr 26 16:10:56 codeman kernel: Out of Memory: Killed process 26038
> (mysqld).
> Apr 26 16:11:01 codeman kernel: Out of Memory: Killed process 3914 (pico).
> Apr 26 16:11:01 codeman kernel: VM: killing process pico
> Apr 26 16:11:04 codeman kernel: Out of Memory: Killed process 20471 (squid).
>
> So, you guess, apache, mysqld, squid and the causer pico are killed, but NO, 
> ONLY, and i mean ONLY pico was killed, all the other Processes listed above 
> are running fine, accepting connections, short: works fine!!
> And yes, its reproduceable !!
>
> The above is a kernel without rmap!

Try with -AA (splitted vm33), latest ist 2.4.19pre7aa2.
It works for "ages".

Regards,
	Dieter

BTW Have anyone a copy of these nice "test.c" for the OOM, handy?

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
