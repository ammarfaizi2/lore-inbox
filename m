Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267181AbRGKBtk>; Tue, 10 Jul 2001 21:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbRGKBt3>; Tue, 10 Jul 2001 21:49:29 -0400
Received: from web14404.mail.yahoo.com ([216.136.174.61]:29966 "HELO
	web14404.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267181AbRGKBtS>; Tue, 10 Jul 2001 21:49:18 -0400
Message-ID: <20010711014918.76554.qmail@web14404.mail.yahoo.com>
Date: Tue, 10 Jul 2001 18:49:18 -0700 (PDT)
From: Rajeev Bector <rajeev_bector@yahoo.com>
Subject: new IPC mechanism ideas
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are planning to develop a new
IPC mechanism based on shared
memory. The memory is allocated by
a device driver in the kernel
and mapped to various processes
read only. Processes talk to the
driver to write to the memory
but they can directly read the
memory (so its a 1-copy IPC
mechanism). 

We also want to make this IPC
mechanism persistent across
application restarts. So that
if an application crashes, when
it comes back up, it can remap
to its old queues and get its
messages. 

Does anyone have experiences building
such a mechanism ? Any pointers to
reading material would be really
appreciated ? 

Please cc replies to rajeev_bector@yahoo.com

Thanks !

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
