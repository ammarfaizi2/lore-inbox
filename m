Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276561AbRJMGze>; Sat, 13 Oct 2001 02:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276675AbRJMGzY>; Sat, 13 Oct 2001 02:55:24 -0400
Received: from [212.17.18.2] ([212.17.18.2]:37386 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id <S276561AbRJMGzL> convert rfc822-to-8bit;
	Sat, 13 Oct 2001 02:55:11 -0400
Message-Id: <200110130655.f9D6tfX00768@gw.ac-sw.com>
Content-Type: text/plain; charset=US-ASCII
From: Stepan Kalichkin <step@ac-sw.com>
Organization: NGTS
To: linux-kernel@vger.kernel.org
Subject: Re: qsbench on old kernels
Date: Sat, 13 Oct 2001 13:56:34 +0700
X-Mailer: KMail [version 1.3.5]
In-Reply-To: <3.0.6.32.20011011104544.01e9bea0@pop.tiscalinet.it>
In-Reply-To: <3.0.6.32.20011011104544.01e9bea0@pop.tiscalinet.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I compiled qsbench under windows 2000
And get some interesting results:

Under my linux kernel  2.4.9-ac18
 
localhost:~/test/qs_bench > time ./qsbench -n 90000000 -p 1 -s 14538
seed = 14538
 
real    1m50.442s
user    1m48.410s
sys     0m1.660s

And under windows with same parameters:
seed = 14538
time = 48s

--
seed = 14538
time = 47s

--
seed = 14538
time = 48s

May be this comparison is't correctly
but so large difference!
Any comments?
