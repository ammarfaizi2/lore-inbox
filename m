Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQLLNp4>; Tue, 12 Dec 2000 08:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLLNpq>; Tue, 12 Dec 2000 08:45:46 -0500
Received: from pop.gmx.net ([194.221.183.20]:44775 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129401AbQLLNpb>;
	Tue, 12 Dec 2000 08:45:31 -0500
Date: Tue, 12 Dec 2000 14:17:04 +0100
From: Matthias Czapla <dermatsch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: cdrom doesnt work anymore with 2.4
Message-ID: <20001212141704.A225@st3>
Reply-To: Matthias Czapla <dermatsch@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a quite old cdrom drive, called Cyberdrive 240D. With linux 2.2.17
it worked with soemtimes odd behavior, but it worked.
With 2.4.0-test11 I can mount cdroms in it but if I want to access it (eg.
ls, cd...) I get messages like:
_isofs_bmap: block >= EOF (1096810496, 2048)
or 
_isofs_bmap: block < 0

However booting with 2.2.17 it works.
Here is info from ver_linux:

Linux st3 2.4.0-test11 #6 Die Dez 12 13:12:45 CET 2000 i686 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Gnu Make               3.78.1
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         tvmixer soundcore msp3400 tuner bttv videodev i2c-algo-bit i2c-core 

I tried the cruft mountoption, without success. What else could I do, or is
there no hope for this old drive?
Thank you.

PS: It seems this is mailing-list. Im not subscribed to it.

-- 
schüss,
Matthias Czapla
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
