Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136116AbRD0Q3N>; Fri, 27 Apr 2001 12:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136118AbRD0Q3D>; Fri, 27 Apr 2001 12:29:03 -0400
Received: from [209.225.10.21] ([209.225.10.21]:10746 "HELO mailrelay.local")
	by vger.kernel.org with SMTP id <S136116AbRD0Q2v>;
	Fri, 27 Apr 2001 12:28:51 -0400
Message-ID: <3AE97687.A83EA963@elsitio.com.ar>
Date: Fri, 27 Apr 2001 13:39:19 +0000
From: Federico Edelman Anaya <fedelman@elsitio.com.ar>
Reply-To: fedelman@elsitio.com.ar
Organization: El Sitio
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: FD in Kernel 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I am newbie in this list! .. I'm Federico Edelman Anaya ... well! ..
I have a question ...

I need increase the FD (File Descriptors) ... I was change the value of
the FD in kernel 2.2.17:

/usr/include/bits/types.h:
#define __FD_SETSIZE    1024    ->  4096

/usr/src/linux/include/linux/posix_types.h
#define __FD_SETSIZE    1024    ->  4096

/usr/src/linux/include/linux/tasks.h
#define NR_TASKS           512     ->  2048   /* On x86 Max 4092, or
4090 w/APM configured. */


Well... Kernel 2.4.3:
/usr/include/bits/types.h:
#define __FD_SETSIZE    1024    ->  4096

/usr/src/linux/include/linux/posix_types.h
#define __FD_SETSIZE    1024    ->  4096

It's only change was posible to do ... Because, tasks.h doesn't exist!

How can I do to increase the FD in the Kernel 2.4.3?

Thanks!




