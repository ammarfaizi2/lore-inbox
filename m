Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289821AbSBKPDK>; Mon, 11 Feb 2002 10:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289820AbSBKPDA>; Mon, 11 Feb 2002 10:03:00 -0500
Received: from rohrpostix.brk-muenchen.de ([194.25.85.212]:61393 "EHLO
	rohrpostix.brk-muenchen.de") by vger.kernel.org with ESMTP
	id <S289821AbSBKPC4>; Mon, 11 Feb 2002 10:02:56 -0500
Message-ID: <410B51F29EA8D3118EE400508B44AE2B3C6FB3@RZ_NT_MAIL>
From: "Proescholdt, timo" <Timo.Proescholdt@brk-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: randomness - compaq smart array driver
Date: Mon, 11 Feb 2002 16:00:39 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
X-BRKkvmuenchen: processed by rohrpostix.brk-muenchen.de queue id g1BF2n231428 at Mon Feb 11 16:02:49 2002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux community,


I have a question concerning /dev/random on proliant servers with 
smart array controllers.
A month ago i tried to install freeswan on a proliant dl360 box,
running redhat 6.2 on a smart array controller.
There are no disks hanging at the scsi controller only the 
two disks at the smart array controller channel. Kernel is 2.4.14 .

I noticed that the installation fails due to missing randomness.
I can confirm that as cat /dev/random does not provide any output.

Looking and asking arround i found out that the smart array
controller driver has a bug (?) so that it does not provide 
any information to the kernel random functions.
Because i am working on the machine over a ssh connection
there is no mouse / keyboard input, so randomness
depends on disk aktivity only. As the only disks on the
system are connected to the smart array controller 
no random data can be created.

I heard that there is a patch for 2.2.x kernels, wich deals with this
topic , but i cannot find this patch anywere .
Is there a similar patch for 2.4.x kernels?
Will this problem be solved in the next future?
Can anybody tell me if this problem is known, are there
any workarrounds / solutions ?

many thanks 

Timo Proescholdt
