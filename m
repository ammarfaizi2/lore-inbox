Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbQKOR1d>; Wed, 15 Nov 2000 12:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130364AbQKOR1X>; Wed, 15 Nov 2000 12:27:23 -0500
Received: from mx3.port.ru ([194.67.23.37]:25609 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S129547AbQKOR1S>;
	Wed, 15 Nov 2000 12:27:18 -0500
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: testXX and PPPD 2.4.0-release
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.71]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E13w5s0-0001WY-00@f11.mail.ru>
Date: Wed, 15 Nov 2000 19:57:14 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         DESCRIPTION:
     Happen on 2.4.0-testXX, doesnt on 2.2.X
     pppd 2.4.0-b2,b4,release, ppp async in kernel
     Sportster 14400 Vi (if that hell does matter)
      AND! UART 16450!
     I`ve described such a problem to PPP maintainers
   about half-year ago, but got nothing.

     Now it looks like that this problem is /tolerable/
  in 2.4.0-testn; n>7, even when in older tests i was     just a small hell.
    
         PROBLEM ITSELF:
    ~12.5% of small file transfers stalls at beginning,
    when modem lights still flashes and ppp0 interface
    error count significantly grow. it looks like
    data is there, but ppp refuses to take it.
  
    it may look ok, just like some random factor, BUT!
    *this*happens*on*same*files*or*byte*sequences!
    e.g. every one of posted on lkml by Dag Brattli
    irda-posts/mails only downloads by 2.5k, e.g. 
    2 packets... =(
    for another example approx 3 of 25 posts on lkml
    are undownloadable...
    another detail: tcp_ecn=0

    whats the hell?
    
     
     
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
