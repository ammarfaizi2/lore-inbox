Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268557AbRGYLVo>; Wed, 25 Jul 2001 07:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268559AbRGYLVe>; Wed, 25 Jul 2001 07:21:34 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:6151 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268557AbRGYLV3>;
	Wed, 25 Jul 2001 07:21:29 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Mohanan P G <pgm@krec.ernet.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: Panic on boot (Intel system ) 
In-Reply-To: Your message of "Wed, 25 Jul 2001 05:43:18 +0530."
             <Pine.LNX.4.30.0107250542190.2447-100000@nanda.krec.ernet.in> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 25 Jul 2001 21:21:27 +1000
Message-ID: <9148.996060087@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001 05:43:18 +0530 (IST), 
Mohanan P G <pgm@krec.ernet.in> wrote:
>Stack: c1254000 00000286 00000004 00000000 c0119e6d 00000004 c1255f38 c1254558
>       c1254000 00000286 00000004 c0119f1c 00000004 c1255f38 c1254000 c1254000
>       00000286 00000000 00000004 c0119fb9 00000004 c1255f38 c1254000 c1254000
>CallTrace: [<c0119e6d>] [<c0119f1c>] [<c0119fb9>] [<c0107244>] [<c01072a3>] [<c012026d>] [<c01202b1>]
>[<c0106c4c>]
>Code c7 01 00 00 00 00 8b 45 04 89 08 89 4d 04 85 f6 74 07 83 fe
>Stack: c1254000 00000286 00000004 00000000 c0119e6d 00000004 c1255f38 c1254558
>       c1254000 00000286 00000004 c0119f1c 00000004 c1255f38 c1254000 c1254000
>       00000286 00000000 00000004 c0119fb9 00000004 c1255f38 c1254000 c1254000
>[<c0106c4c>]
>Warning (Oops_read): Code line not seen, dumping what data is available

Your oops text is not in quite the right format.  ksymoops looks for
'Call Trace:' (space between Call and Trace:) and 'Code:' (: after
Code).  If you adjust your text to match what the kernel actually
produced then rerun ksymoops you will get a better oops report.  Please
send the clean oops report to linux-kernel, not to me.

