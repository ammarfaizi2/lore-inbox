Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRDCLLn>; Tue, 3 Apr 2001 07:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131606AbRDCLLd>; Tue, 3 Apr 2001 07:11:33 -0400
Received: from [212.115.175.146] ([212.115.175.146]:28402 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S131629AbRDCLLa>; Tue, 3 Apr 2001 07:11:30 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F113E@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: unresolved symbols; I must have lost my brain
Date: Tue, 3 Apr 2001 13:10:07 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People,

Somehow I must have lost my brain.
In exit.c I introduced some array:

pid_t pidarray[100];

in fork.c I refer to this array:

extern pid_t pidarray[100];

(or something like that. looked it up in K&R, couldn't
find what I did wrong)

for some reason the kernel build process complains
about the pidarray it could not find.
This is a very trivial problem, but, well, I'm not
seing it. Tried to move the declaration to some
header-file, etc. etc. Done it all, doesn't work.

Anyone who can shed some light on this problem?
