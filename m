Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbQLKASH>; Sun, 10 Dec 2000 19:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbQLKAR5>; Sun, 10 Dec 2000 19:17:57 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:21008 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129906AbQLKARt>; Sun, 10 Dec 2000 19:17:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Tim <tim@parrswood.manchester.sch.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in test11, test11-ac4 and test12-pre4/7 
In-Reply-To: Your message of "Sun, 10 Dec 2000 17:44:06 -0000."
             <Pine.LNX.4.21.0012101742020.3920-100000@pine.parrswood.manchester.sch.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Dec 2000 10:47:17 +1100
Message-ID: <1051.976492037@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000 17:44:06 +0000 (GMT), 
Tim <tim@parrswood.manchester.sch.uk> wrote:
>Dec 10 17:08:24 oxygen kernel: Call Trace: [<d08925b7>] [call_spurious_interrupt+33951/35940] [sprintf+20/28] [call_spurious_interrupt+33924/35940] [do_resource_list+77/132] [call_spurious_interrupt+33907/35940] [<d08925b7>]

Yet another completely broken klogd oops conversion.  Always run klogd
as "klogd -x", probably started from /etc/rc.d/init.d/syslog.

>Dec 10 17:08:24 oxygen kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 c6 8b 44 24 1c

Not decoded.  Get a clean oops (without klogd getting in the way) then
run the clean oops through ksymoops.  Documentation/oops-tracing.txt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
