Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280978AbRLVQLV>; Sat, 22 Dec 2001 11:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286812AbRLVQLL>; Sat, 22 Dec 2001 11:11:11 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:54072 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S286808AbRLVQLB>; Sat, 22 Dec 2001 11:11:01 -0500
Message-Id: <4.3.2.7.2.20011222080457.00be8100@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 22 Dec 2001 08:10:25 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        dirk@staf.planetinternet.be (Dirk Moerenhout)
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in
  Configure.hel
Cc: jeffm@iglou.com (Jeff Mcadams), linux-kernel@vger.kernel.org
In-Reply-To: <E16HnxA-0004SS-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.33.0112221538560.214-100000@dirk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:20 PM 12/22/01 +0000, Alan Cox wrote:
>It gets worse the deeper you go. Over an HDLC based link for example
>sequences of five one bits take longer to send due to bitstuffing. Any
>networking terminology is generally grossly simplified.

Interestingly, the subject of bit-stuffing came up during the discussion of 
modem testing, because of the HDLC framing used in V.42 error 
control.  Statistics provided by the representative from Hayes (R.I.P.) 
showed that bit-stuffing occurred in roughly 1 out of 64 bits in the data 
path when V.42 bis data compression was enabled.  The 1:63 ratio held over 
a surprisingly wide range of data patterns, all the way from repeated 
single characters through text in English, French, German, and Chinese to 
the output of a 64-bit random number generator.  When v.42 bis data 
compression was disabled, the average ratio was about the same but there 
was considerably more spread because of data pattern sensitivity.

Which is grossly off-topic but I thought a few of you might be interested.

Stephen Satchell

