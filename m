Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272710AbRIMWbR>; Thu, 13 Sep 2001 18:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272711AbRIMWbH>; Thu, 13 Sep 2001 18:31:07 -0400
Received: from louie.udel.edu ([128.4.40.12]:35247 "HELO mail.eecis.udel.edu")
	by vger.kernel.org with SMTP id <S272710AbRIMWay>;
	Thu, 13 Sep 2001 18:30:54 -0400
Message-ID: <3BA134F3.FA661E9E@udel.edu>
Date: Thu, 13 Sep 2001 18:36:35 -0400
From: "Antonios G. Danalis" <danalis@udel.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: increasing HZ in Linux kernel
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to increase the frequency of the clock interrupt up
to ~10000 to run some experiments.

In the kernel I'm using (2.4.2-2) I've noticed that
if you increase HZ above 1536 you get a conflict with
.../include/linux/timex.h:75-77
and if you add some lines there, you get a problem with
.../include/net/tcp.h:377
when HZ is above 4096.

Is there an easy way to increase clock interrupt freq, or
do I have to mess with the whole kernel ?

Thanks in advance.
Antonios

