Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268332AbRHJN51>; Fri, 10 Aug 2001 09:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbRHJN5W>; Fri, 10 Aug 2001 09:57:22 -0400
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:6547 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S268331AbRHJN4n>; Fri, 10 Aug 2001 09:56:43 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: 2.4.8-pre8 (final?) use-once-pages-2 is missing?
Date: Fri, 10 Aug 2001 15:55:46 +0200
X-Mailer: KMail [version 1.2.3]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Chris Mason <mason@suse.com>, "Vladimir V.Saveliev" <vs@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010810135712Z268331-28345+2705@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

your latest "try" is great so far...;-)
Even my reported ReiserFS disk IO performance drop seems to be solved.
But you have forgotten to apply Daniel's use-once-pages-2?
Or is it unneeded, now?

I'll retry to compare
2.4.7-ac1 +
use-once-pages					Daniel Phillips
use-once-pages-2				Daniel Phillips
transaction-tracking-2.diff				Chris Mason
2.4.7-unlink-truncate-rename-rmdir.dif 		Vladimir V.Saveliev
2.4.7-plug-hole-and-pap-5660-pathrelse-fixes.dif	Vladimir V.Saveliev


2.4.8-pre8 +
use-once-pages-2				Daniel Phillips
transaction-tracking-2.diff				Chris Mason
2.4.7-unlink-truncate-rename-rmdir.dif 		Vladimir V.Saveliev
2.4.7-plug-hole-and-pap-5660-pathrelse-fixes.dif	Vladimir V.Saveliev

Regards,
	Dieter

BTW	Someone mentioned 2.4.8 final. Can't find it.
BTW2 	You should use 10.000 or even 15.000 RPM U160/320 IBM disks...:-)))

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
