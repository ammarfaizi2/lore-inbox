Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRKMRjx>; Tue, 13 Nov 2001 12:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277629AbRKMRjo>; Tue, 13 Nov 2001 12:39:44 -0500
Received: from f191.law7.hotmail.com ([216.33.237.191]:37644 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S277435AbRKMRj0>;
	Tue, 13 Nov 2001 12:39:26 -0500
X-Originating-IP: [63.114.211.31]
From: "Adam Margulies" <aamargulies@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: RE: odd memory behaviour in 2.4.15
Date: Tue, 13 Nov 2001 12:39:20 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F191xWY5pCxlICSsiWd0000b164@hotmail.com>
X-OriginalArrivalTime: 13 Nov 2001 17:39:20.0772 (UTC) FILETIME=[2052E040:01C16C6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this has been covered before, however I
am puzzled by this situation and so am asking the list for help.

I have a rack of 14 linux machines, each with 4GB of RAM.
They run great, no problems, using the 2.4.10 kernel.

I have a separate linux machine with identical hardware
running 2.4.15 which also ran well, until I upgraded its
memory to 4GB. Then it ran 3 times slower than with 1 GB of RAM.

I know the solution is to put an "append="mem=3900M""
in lilo.conf, sacrificing 287MB in the process,
but my question is why do I have to do this?
and why do the 4GB 2.4.10 machines run fine without it?

I've compared their .configs and while they are different
they aren't different in the important settings, such
as the memory configuration settings. So I don't think
it is a kernel config issue.


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

