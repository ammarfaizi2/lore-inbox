Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312836AbSCZXau>; Tue, 26 Mar 2002 18:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSCZXak>; Tue, 26 Mar 2002 18:30:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55562 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312833AbSCZXad>; Tue, 26 Mar 2002 18:30:33 -0500
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Tue, 26 Mar 2002 23:47:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        andihartmann@freenet.de (Andreas Hartmann),
        linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <Pine.LNX.4.33.0203261210540.26944-100000@twinlark.arctic.org> from "dean gaudet" at Mar 26, 2002 12:24:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16q0ee-0004Dx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what's the point if you're just going to get signal delivery when you
> least want it, even when malloc returns non-NULL?  it could even be due to

If you are running with no overcommit you'll always (for any statistically
interesting case get the malloc NULL and no signals)

> it's guaranteed to work in all cases.  (hence, apache-1.3 and other
> multiprocess daemon superiority over threaded and event-driven code, tee
> hee :)

thttpd -> 1000 hits/second on a 32Mb pentium

I don't hear you 8)

