Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278030AbRJIWcp>; Tue, 9 Oct 2001 18:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278028AbRJIWcf>; Tue, 9 Oct 2001 18:32:35 -0400
Received: from sushi.toad.net ([162.33.130.105]:35482 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S278027AbRJIWc3>;
	Tue, 9 Oct 2001 18:32:29 -0400
Subject: Re: Linux 2.4.10-ac10
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: bunk@fs.tum.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 09 Oct 2001 18:32:30 -0400
Message-Id: <1002666753.763.4.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the two notable difference in the syslog are:
1) Parport now reports that it is going to use DMA 7
   instead of DMA 3;
2) On the second boot ioport 0x530 is reported not to be free
   and this prevents ad1816 from loading

Two questions:
1) Is the parport actually configured to use DMA7, not DMA3? 
   Please check using "lspnp -v 0d" and also by any other
   methods you have access to
2) What is using 0x530?  What's in /proc/ioports?

--
Thomas Hood

