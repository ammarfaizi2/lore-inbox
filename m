Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130353AbRCBI3b>; Fri, 2 Mar 2001 03:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130355AbRCBI3V>; Fri, 2 Mar 2001 03:29:21 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:54565 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S130353AbRCBI3R>;
	Fri, 2 Mar 2001 03:29:17 -0500
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200103020828.AAA36344@google.engr.sgi.com>
Subject: Linux/mips64 on 64 node, 128p, 64G machine
To: linux-kernel@vger.kernel.org
Date: Fri, 2 Mar 2001 00:28:16 -0800 (PST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a quick note to mention that I was successful in booting up a
64 node, 128p, 64G mips64 machine on a 2.4.1 based kernel. To be able
to handle the amount of io devices connected, I had to make some 
fixes in the arch/mips64 code. And a few to handle 128 cpus.

A couple of generic patches needed to be made on top of 2.4.1 
(obviously, the prime one was that NR_CPUS had to be bumped to 128).
I will clean the patches up and send them in to Linus.

For some output, visit

    http://oss.sgi.com/projects/LinuxScalability/download/mips128.out

I ommitted the bootup messages, since they are similar (just a lot
longer!) to the 32p bootup messages at

    http://oss.sgi.com/projects/LinuxScalability/download/mips64.out

Kanoj

