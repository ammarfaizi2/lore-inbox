Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275207AbRJFPIa>; Sat, 6 Oct 2001 11:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275210AbRJFPIU>; Sat, 6 Oct 2001 11:08:20 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:9492 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S275207AbRJFPIM> convert rfc822-to-8bit; Sat, 6 Oct 2001 11:08:12 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: OOM-Killer in 2.4.11pre4
Date: Sat, 6 Oct 2001 17:06:53 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <E15plMj-0002eK-00@mrvdom01.schlund.de> <20011006162617.A724@athlon.random>
In-Reply-To: <20011006162617.A724@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E15pt4D-0002N4-00@mrvdom02.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> to test the oom killer you should try to run out of memory sometime.

I used a test program with an endless dummy=new char[1024] loop.

This program triggered the allocation failure with 2.4.10 but with 2.4.11pre4 
this program is killed by the OOM-Killer and not by the VM.
Bytheway,I had this problem without highmem - only 512 MB, and  my problem is 
gone with 2.4.11pre4. 
At least this bug is solved. There is nothing more I wanted to report.
Good work :-)

greetings

Christian Bornträger
