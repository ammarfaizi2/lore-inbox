Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbRHKO62>; Sat, 11 Aug 2001 10:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267974AbRHKO6S>; Sat, 11 Aug 2001 10:58:18 -0400
Received: from mx6.port.ru ([194.67.57.16]:13066 "EHLO mx6.port.ru")
	by vger.kernel.org with ESMTP id <S267890AbRHKO6G>;
	Sat, 11 Aug 2001 10:58:06 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: strange gcc crashes...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.62]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15VaDR-000N0H-00@f9.mail.ru>
Date: Sat, 11 Aug 2001 18:58:17 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       I`ve experienced strange gcc sig11 crashes.
    prerequisities: gcc-2.95.3-vanille, 2.4.7-vanille

    recently i`ve dloaded arachne, a svgalib-based
    web browser. It has quite a number of various problems,
    with console-switching screen/terminal corruptions
    being most significant. so as i said, it crashed
    alot, and i recovered from these crashes w/o reboot.

    then i get libggi-2.0.4b4. (that is all happening
    w/o reboot between actions)

    i`ve started compile process. bah! - sig11.

    Although i quite often have those, but
    this time i had about _100_ of them!!!
    all these in libggi. I `ve got tired of tweakin` 
    cflags of different makfiles, because it helps
    to go thru prblematic .c`s, and i rebooted.

    Hm the /most/ mystic of all this is the fact, that 
    after reboot sig11 rate dropped from sig11 per ~4
    files to one per ~120 of them. To make clear
    the situation, i`ll tell that libggi is VERY
    broken for me in the scope of gcc`s sig11.

    also i can say, that the sig11/file rate had been
    constantly increasing with the compilation process.

    so it seems to me like kernel problem...

    further information upon request.

---


cheers,


   Samium Gromoff
