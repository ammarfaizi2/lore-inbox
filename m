Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266094AbSLISkW>; Mon, 9 Dec 2002 13:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSLISkV>; Mon, 9 Dec 2002 13:40:21 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:4334 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S266094AbSLISjl> convert rfc822-to-8bit; Mon, 9 Dec 2002 13:39:41 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <ralf@gnu.org>, <willy@debian.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF6B91BBE3.E3C87169-ONC1256C8A.0066A5C2@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 9 Dec 2002 19:41:41 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 09/12/2002 19:44:13
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You're not looking at a recent 2.5.x tree with the nanosleep() restart
> logic.
I had been looking at 2.5.50, we had a different meaning of current.
If you are saying that for any implementation of nanosleep I have to implement
the -ERESTART_RESTARTBLOCK thingy anyway, then I better start with it.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


