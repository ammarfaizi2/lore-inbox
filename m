Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276248AbRJYUmQ>; Thu, 25 Oct 2001 16:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276249AbRJYUmH>; Thu, 25 Oct 2001 16:42:07 -0400
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:28862 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S276248AbRJYUl7>; Thu, 25 Oct 2001 16:41:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Jim Hull <imaginos@imaginos.net>
Subject: dvd issue now only occurs in 2.4.13
Date: Thu, 25 Oct 2001 22:41:55 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01102522415500.00896@baldrick>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This might be the same as the problem discussed in the
thread
  "xine pauses with recent (not -ac) kernels"
(try searching the list archive).  The conclusion seemed
to be that since there was a workaround if you are
using raw io (doing a

         sleep 100000 < /dev/dvd-device &

in the background before starting xine), the fix could wait
for the 2.5 kernels.

I hope this helps,

Duncan.
