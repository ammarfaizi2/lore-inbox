Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbREOWps>; Tue, 15 May 2001 18:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbREOWpi>; Tue, 15 May 2001 18:45:38 -0400
Received: from mail.sai.co.za ([196.33.40.8]:14088 "EHLO mail.sai.co.za")
	by vger.kernel.org with ESMTP id <S261678AbREOWpb>;
	Tue, 15 May 2001 18:45:31 -0400
From: "David Wilson" <davew@sai.co.za>
To: <linux-kernel@vger.kernel.org>
Subject: FW: I think I've found a serious bug in AMD Athlon page_alloc.c routines, where do I mail the developer(s) ?
Date: Wed, 16 May 2001 00:47:14 +0200
Message-ID: <NEBBJFIIGKGLPEBIJACLEEHDDMAA.davew@sai.co.za>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1 (Highest)
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: High
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, howzit going ? ;-)

Maybe I'm being dumb but I've been working with Linux long enough not to
make a silly mistake *I hope*.

I think I've found a serious bug in AMD Athlon page_alloc.c routines in
kernel 2.4.4.
I'm running an AMD athlon 850 running at 100x8.5, everything is setup
correct on the DFI AK75-EC motherboard, if I set the CPU kernel type to 586
everything is 100%, if I use "Athlon" kernel type I get:
kernel BUG at page_alloc.c:73

The system then dies with:
exit mmap: map count is 13
I also get various "unable to handle paging requests" etc. etc.

I've changed RAM, Motherboard etc... still the same.
Also the same system runs linux-2.2.16 100%

I'm not subscribed to linux-kernel@vger.kernel.org, so please cc me in your
reply to the list.
Thanks.

Regards
David Wilson
Technical Support Centre
The S.A Internet
0860 100 869
http://www.sai.co.za

