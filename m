Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313971AbSDKD2C>; Wed, 10 Apr 2002 23:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313973AbSDKD2B>; Wed, 10 Apr 2002 23:28:01 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:5512 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S313971AbSDKD2A>; Wed, 10 Apr 2002 23:28:00 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 0(1)-patch, where did it go?
Date: Thu, 11 Apr 2002 05:27:35 +0200
X-Mailer: KMail [version 1.4]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Robert Love <rml@tech9.net>,
        George Anzinger <george@mvista.com>, Andrew Morton <akpm@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204110527.35486.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can get an up-to-date version in the 2.4.19-pre6-jam1 patcset in
> 
> http://giga.cps.unizar.es/~magallon/linux/kernel/

Didn't you noticed any of the reports about very bad numbers for latency since 
Ingo's latest 2.4.17-K3 version?
Even Alan's tree show the same (latest I've checked was 2.4.19-pre2-ac2).

We do need some words from Ingo first.
He haven't answered my posts since February ;-(
But yaybe he didn't got them 'cause I send them to mingo@elte.hu ???

If you run without O(1) latency is like before.
You'll get better numbers with preemption+lock-break (ongoing merge of 
Andrew's lowlatency patches).

But I see some kernel hangs with preemption on UP.
It happens only during "make bzlilo" (the linking stage). Robert?
Apart from that it works well.

-Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

