Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131127AbQK2Sic>; Wed, 29 Nov 2000 13:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131685AbQK2SiX>; Wed, 29 Nov 2000 13:38:23 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:20382 "EHLO
        aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
        id <S131127AbQK2SiP>; Wed, 29 Nov 2000 13:38:15 -0500
Message-ID: <3A2545F3.C83F5F19@fi.muni.cz>
Date: Wed, 29 Nov 2000 19:07:47 +0100
From: Zdenek Kabelac <kabi@informatics.muni.cz>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-ac4-RTL3.0-pre9 i686)
X-Accept-Language: Czech, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.LNX.4.10.10011290940070.11951-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 29 Nov 2000 Andries.Brouwer@cwi.nl wrote:
> >
> > > can you give a rough estimate on when you suspect you started seeing it?
> >
> > I reported both cases. That is, I started seeing it a few days ago.
 

I'm seeing this kind of corruption during the tar zxf.
$ tar zxf linux-2.4.0-test11.tar.gz 

gzip: stdin: invalid compressed data--format violated
tar: Unexpected EOF in archive
tar: Child returned status 1
tar: Error exit delayed from previous errors



Currently running kernel is 2.4.0-test11-ac4 and the file is correct.
After the reboot there is no problem with uncompressing this file.
It possible that this problem is fixed with test12-pre3, but in
case its not I'm reporting this now (this already happend to me at least
three times with this kernel - also there are no messages in the kernel
log.


-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
