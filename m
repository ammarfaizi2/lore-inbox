Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265379AbRF0T2w>; Wed, 27 Jun 2001 15:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbRF0T2b>; Wed, 27 Jun 2001 15:28:31 -0400
Received: from mail1.dexterus.com ([212.95.255.99]:3848 "EHLO
	mail1.dexterus.com") by vger.kernel.org with ESMTP
	id <S265379AbRF0T20>; Wed, 27 Jun 2001 15:28:26 -0400
Message-ID: <009b01c0ff3f$67e24b00$470c0a0a@DEVPC01>
From: "Vincent Sweeney" <v.sweeney@dexterus.com>
To: <linux-kernel@vger.kernel.org>
Cc: <kdc@nh.ultranet.com>, <linux-scalability@citi.umich.edu>
Subject: PATCH (2.4.5): /dev/poll support
Date: Wed, 27 Jun 2001 20:28:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think pgp-signing just barfed my last email (typical) so I'm retyping /
resending this:

Hi,
    this patch adds Solaris 7/8 like /dev/poll support to the kernel.

I can claim no real credit for this as basically this is a fixed version of
a patch available from http://www.citi.umich.edu/projects/linux-scalability/
to compile correctly with 2.4.5 that only seemed to work with the 2.3.x
devel branch. The reason for this is so I can compile & test an application
on my home linux pc when I'm not around my nice work Solaris boxes :)

Please note, I have not got the knowledge of kernel development to know if
this patch is broken or badly written. It may be bugged and/or worse than
the standard poll() call but my application works so I'll leave profiling
etc to people more knowledgable than me.

Vince.


