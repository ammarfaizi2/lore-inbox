Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275594AbRJAVuE>; Mon, 1 Oct 2001 17:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275598AbRJAVto>; Mon, 1 Oct 2001 17:49:44 -0400
Received: from mailrelay1.inwind.it ([212.141.54.101]:61165 "EHLO
	mailrelay1.inwind.it") by vger.kernel.org with ESMTP
	id <S275594AbRJAVtf>; Mon, 1 Oct 2001 17:49:35 -0400
Message-Id: <3.0.6.32.20011001235032.02571860@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 01 Oct 2001 23:50:32 +0200
To: Rik van Riel <riel@conectiva.com.br>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.33L.0110011604310.4835-100000@imladris.rielhome
 .conectiva>
In-Reply-To: <3.0.6.32.20011001203320.02381600@pop.tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16.23 01/10/01 -0300, you wrote:
>On Mon, 1 Oct 2001, Lorenzo Allegrucci wrote:
>
>> Disclaimer:
>> I don't know if this "benchmark" is meaningful or not, but anyhow..
>
>I'm not sure either, since qsort doesn't really have much
>locality of reference but just walks all over the place.

Yes, it was exactly my goal :)

>This is direct contrast with the basic assumption on which
>VM and CPU caches are built ;)

Indeed, it put strain the VM by a pseudo random-sequential access pattern.

>I wonder how eg. merge sort would perform ...

It would perform better, but merge sort doesn't trash the system :)
I wanted to test the system in trashing conditions.
Just curious.


-- 
Lorenzo
