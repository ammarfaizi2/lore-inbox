Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRAER5a>; Fri, 5 Jan 2001 12:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130378AbRAER5K>; Fri, 5 Jan 2001 12:57:10 -0500
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:8455 "HELO
	gateway.izba.bg") by vger.kernel.org with SMTP id <S129805AbRAER5H>;
	Fri, 5 Jan 2001 12:57:07 -0500
Date: Fri, 5 Jan 2001 19:57:05 +0200 (EET)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0: Problems on Alpha with NCR53c810
Message-ID: <Pine.LNX.4.10.10101051951010.6358-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
I tried installing 2.4.0 on my digital alpha server 400 /233 , and with no
success... First, I tried compiling it with ncr53c7,8xx driver, and it
failed with signal 1 ( always failed there.... that file never wanted to
compile, no matter how I tried)  ... I blame the compiler there, but I
didn't wanted to change the compiler, and I saw there was another driver
that supports the controler, so I compiled with it, and the machine
stopped at the detection , just doing resets on the SCSI bus... The same
driver works with 2.2.18 ( I checked, in 2.4 the driver is older than in
2.2)... 
  Any ideas?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
