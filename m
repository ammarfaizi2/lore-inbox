Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263712AbSIQGkG>; Tue, 17 Sep 2002 02:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263723AbSIQGkG>; Tue, 17 Sep 2002 02:40:06 -0400
Received: from mex.italtel.it ([138.132.117.4]:25822 "EHLO mex.italtel.it")
	by vger.kernel.org with ESMTP id <S263712AbSIQGkF>;
	Tue, 17 Sep 2002 02:40:05 -0400
Message-ID: <3D86BADD.8F54CA99@imads2.milano.italtel.it>
Date: Tue, 17 Sep 2002 07:17:17 +0200
From: Corrado Cappello <Corrado.Cappello@italtel.it>
Organization: Italtel S.p.A.
X-Mailer: Mozilla 4.5 [it] (WinNT; I)
X-Accept-Language: it
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: restore file in tar from a magnetic tape
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I use the same tape and the same environment (OS 2.4.3.12 and CPU
ALPHA EV6) i have observed:

    the system crash happens during rewind the tape; in fact if I
substitute /dev/st0
    with /dev/nst0 and so i don't active the "close" system call in
rewind mode, 3 times on 3
    tar file is restored.

    Now I want see what happens in controller's (QLOGIC ISP1020) driver
during the close.
   
    Someone has any ideas?

    Thank you

    cappelc
-- 
+----------------------------------+
 Corrado Cappello Italtel spa
 TPD-SP-PE-U
 E-Mail:corrado.cappello@italtel.it
	Phone	(+39.2)43888991
	Fax  	(+39.2)43888705
	Mobile	(+39.2)43884212
+----------------------------------+
