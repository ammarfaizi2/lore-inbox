Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbUL0Vwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUL0Vwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 16:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUL0Vwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 16:52:43 -0500
Received: from warsl404pip6.highway.telekom.at ([195.3.96.89]:49186 "HELO
	email09.aon.at") by vger.kernel.org with SMTP id S261230AbUL0Vwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 16:52:38 -0500
Message-ID: <41D08472.6010404@aon.at>
Date: Mon, 27 Dec 2004 22:53:54 +0100
From: Georg Prenner <georg.prenner@aon.at>
Reply-To: georg.prenner@aon.at
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: make errors (make clean, make menuconfig) make -C /usr/src/linux-2.6.10
 O=/usr/src/linux-2.6.10 menuconfig
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am having a problem when executing "make menuconfig" on my fresh 
extracted 2.6.10 kernel.

The error message is like this:

make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
.
.
.
.
.
.
.
I can only stop this neverending message with Strg+C and then it goes on 
like this:
make[85]: *** [menuconfig] Interrupt
make[84]: *** wait: No child processes.  Stop.
make[84]: *** Waiting for unfinished jobs....
make[84]: *** wait: No child processes.  Stop.
make[83]: *** [menuconfig] Error 2
make[82]: *** [menuconfig] Interrupt
make[81]: *** [menuconfig] Interrupt
..
.
.

All other Versions of Kernels work perfectly, I use Make 3.80, and my 
distro is slackware 10.0.

Please help me i can't find anything usefull on the WEB.

THANKS

georg.prenner@aon.at
