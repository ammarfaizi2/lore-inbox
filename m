Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277333AbRJEJNH>; Fri, 5 Oct 2001 05:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277334AbRJEJM5>; Fri, 5 Oct 2001 05:12:57 -0400
Received: from mail.scs.ch ([212.254.229.5]:13745 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S277333AbRJEJMw>;
	Fri, 5 Oct 2001 05:12:52 -0400
Message-ID: <3BBD7B07.1B030E3D@scs.ch>
Date: Fri, 05 Oct 2001 11:19:03 +0200
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
CC: petal.scs@scs.ch
Subject: RAW I/O Performance
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

We are using RedHat's 2.4.3-12 kernel for our Alpha machines and
stumbled over a bad performance problem with raw devices:

Our test results (with a couple of disks and controllers ;-) were:

Kernel 2.2.18        ~200MB/s        95% idle
Kernel 2.4.3-12(RH)  ~105MB/s         0% idle
Kernel 2.4.11-pre3   ~173MB/s        28% idle

The 2.2.18 kernel is using the SGI raw device patches.

I saw that Andrea had a patch for 2.4.3aa where he could improve the RAW
I/O performance significantly. I looked at the patch and I could not
apply it to 2.4.3-12 because of conflicts which I was not able to
resolve.

I also looked at 2.4.10 and saw that Andreas patch was not in there. 

How can I get a similar RAW-IO performance with 2.4.3-12 as I had with
2.2.18? 

TIA

Reto
