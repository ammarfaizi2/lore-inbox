Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTIRU2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 16:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTIRU2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 16:28:18 -0400
Received: from imo-d02.mx.aol.com ([205.188.157.34]:16518 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S262120AbTIRU2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 16:28:11 -0400
Date: Thu, 18 Sep 2003 16:28:08 -0400
From: bee71e@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Re: excessive swapping in 2.4.x
MIME-Version: 1.0
Message-ID: <3C19C4AA.6428E24C.0005DAE9@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 209.131.38.143
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:

>
>
>bee71e@netscape.net wrote:
>
>>Hi, 
>>
>>I am using 2.4.21 and I see an unusually large amount of swapping for relatively low load : 
>>
>>sample vmstat output: (note that the system is almost idle)
>>
>>  procs                      memory    swap          io     system         cpu
>>r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>>0  2  0 1850220  10524   9412 703652 3030 1102  3912  1106 1506  1710   1   1  98
>>0  2  0 1849188  10572   9388 700568 2780 376  3558   379 1434  1284   1   1  99
>>0  5  0 1851576  11668   9404 698228 2999 479  3890   488 1499  1487   1   1  98
>>
>>Is this a known issue? Whats happening? How do I fix this?
>>
>
>You could try the latest 2.4 prerelease. It has some VM updates.

thanks. Will do that. btw, I narrowed down this particular issue to a hardware failure. 

__________________________________________________________________
McAfee VirusScan Online from the Netscape Network.
Comprehensive protection for your entire computer. Get your free trial today!
http://channels.netscape.com/ns/computing/mcafee/index.jsp?promo=393397

Get AOL Instant Messenger 5.1 free of charge.  Download Now!
http://aim.aol.com/aimnew/Aim/register.adp?promo=380455
