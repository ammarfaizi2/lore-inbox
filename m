Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSFMIOh>; Thu, 13 Jun 2002 04:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317492AbSFMIOg>; Thu, 13 Jun 2002 04:14:36 -0400
Received: from isolaweb.it ([213.82.132.2]:44303 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S317491AbSFMIOg>;
	Thu, 13 Jun 2002 04:14:36 -0400
Message-Id: <5.1.1.6.0.20020613095304.00a6fc60@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 13 Jun 2002 10:13:35 +0200
To: linux-kernel@vger.kernel.org
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Developing multi-threading applications
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm designing a multithreding application with many threads,
from ~100 to 300/400. I need to take some decisions about
which threading library use, and which patch I need for the
kernel to improve the scheduler performances. The machines
will be a SMP Xeon with 4/8 processors with 4Gb RAM.
All threads are almost computational intensive and the library
need a fast interprocess comunication and syncronization
because there are many sync & async threads time
dependent and/or critical. I'm planning, in the future, to distribuite
all the threads in a pool of SMP box.

Thanks in advance.

Roberto Fichera.

