Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132122AbRDAKBe>; Sun, 1 Apr 2001 06:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbRDAKBY>; Sun, 1 Apr 2001 06:01:24 -0400
Received: from www.mauimail.com ([209.223.182.70]:54789 "EHLO MauiMail.com")
	by vger.kernel.org with ESMTP id <S132122AbRDAKBM>;
	Sun, 1 Apr 2001 06:01:12 -0400
From: "unreal ROOT!" <root@888.nu>
Subject: unresolved symbol queue_task !
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.4.2
Date: Sat, 31 Mar 2001 21:55:47 -0800
Message-ID: <web-37332@MauiMail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello sirs ;

A part of my source is like this :
       static struct tq_struct Task = { /* Some inits */ };
       queue_task(&Task,&tq_timer);
With the line  #include <linux/tqueue.h>

When ever I compile my source as a module ,insmod tells me
"Unresolved symbole queue_task" .It seems that I have problem with
__inline__ functions .
How sholud I write my source ... What's the problem with inline
functions ?
              Regards
                ica
                >8{
_____________________________________________
Get Your Free Email from http://www.888.nu/
