Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318428AbSGRWaH>; Thu, 18 Jul 2002 18:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318427AbSGRWaH>; Thu, 18 Jul 2002 18:30:07 -0400
Received: from [203.24.179.114] ([203.24.179.114]:59407 "HELO aimedics.com")
	by vger.kernel.org with SMTP id <S318428AbSGRWaG> convert rfc822-to-8bit;
	Thu, 18 Jul 2002 18:30:06 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: nejhdeh <nejhdeh@aimedics.com>
Organization: AiMedics Pty. Ltd.
To: linux-kernel@vger.kernel.org
Subject: Basic question
Date: Fri, 19 Jul 2002 08:31:55 +1000
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207190831.55757.nejhdeh@aimedics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks to your reply erlier. I successfult compiled my device driver separatly 
as module.o and then ran a script to insmod into the kernel.

I have another basic question.

I have two PC systems. First one acts as my development system which I 
develope code using KDevelop running Red Hat linux (2.4.18). When I compile 
my application code (say app.0) and my device driver code (say module.o) then 
I FTP these files into my target system which is a scalled down single-board 
computer (with minimal RAM and disk) which runs linux 2.2.20.

Most of the time everything is O.K. However, when it comes to the device 
driver module (module.o), I get some kernel mismatch problems (obvisouly).

E.g. the file_operations struct in 2.2.20 is different to 2.4.18

My question is: How can I tell gcc or even within the module itself (e.g. 
KERNEL_VERSION) to compile for lower version kernel (i.e tell kernel 2.4.18 
to compile for 2.2.20)

Regards

Nejhdeh Ghevondian

