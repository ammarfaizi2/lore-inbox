Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129936AbQKNMFs>; Tue, 14 Nov 2000 07:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130168AbQKNMFi>; Tue, 14 Nov 2000 07:05:38 -0500
Received: from mx1.port.ru ([194.67.23.32]:50189 "EHLO mx1.port.ru")
	by vger.kernel.org with ESMTP id <S129936AbQKNMFX>;
	Tue, 14 Nov 2000 07:05:23 -0500
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test9/PPPD2.4.0-release
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.70]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E13veMl-000Bjg-00@f6.mail.ru>
Date: Tue, 14 Nov 2000 14:35:07 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Maybe i`d better to post this problem to
  linux-ppp ML, but i`ve reported already it to PPP
maintainers about half year ago, thus i felt ok to post
here. And so the problem:
     I`m unable sometimes to get files thru HTTP, and
the way its happening is very strange for me:
     it looks like the packets with file are on place,
     but kernel rejects `em, fact of what is reflected
     in significant growth of errors of PPP inteface
    showed by ifconfig. I checked what error count
    increase is contemporary with flashing lights on
    my Sportster 14400 Vi. But thats half of the
problem, because this afaik is not a 100% error. It
    wouldn`t have look that strange for me, if i had
    that with different files. BUT for ex. i cant get
"http://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg12187.html", and that happens with about 20% of
small files i retrieve thu web... =(. That problem
afaik doesnt extend to large files (e.g >10k)
        Usually receive stalls on 1 or 2 kbytes.

      Having 2.4.0-test9/pppd 2.4.0-release.
            Encountering that ONLY on 
       2.4.0-testXX series, NOT in 2.2.XX (for ex.
     2.2.17 goes well with that).
     Again, 2.4.N with n<~7 were absolutely unworkable,
    e.g. the procent of "rejected" small files lied
     around 80%.

Sorry for ugly english/stupidness, i`m foreign
                                 non-kernelhacker.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
