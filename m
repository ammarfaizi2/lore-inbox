Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280577AbRKFVWP>; Tue, 6 Nov 2001 16:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280579AbRKFVV4>; Tue, 6 Nov 2001 16:21:56 -0500
Received: from f272.law9.hotmail.com ([64.4.8.147]:62726 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S280577AbRKFVVv>;
	Tue, 6 Nov 2001 16:21:51 -0500
X-Originating-IP: [128.2.152.69]
From: "William Knop" <w_knop@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Date: Tue, 06 Nov 2001 16:21:45 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F272lT2NqFJ3sl3xbYi00004f63@hotmail.com>
X-OriginalArrivalTime: 06 Nov 2001 21:21:45.0845 (UTC) FILETIME=[09B72A50:01C16709]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>1)  IT SHOULD NOT BE PRETTY.  No tabs to line up columns. No "progress
>>bars."  No labels except as "proc comments" (see later).  No in-line
>>labelling.
>
>It should not be pretty TO HUMANS. Slight difference. It should be >pretty 
>to shellscripts and other applications though.

If this is the case, why are we using ASCII for everything? If the only 
interface to /proc will be applications, then we could just as well let the 
application turn four bytes into an ASCII IPv4 adddress. We could easily 
have it set up to parse using the format [single byte type identifier (ie 4 
for string with the first byte of "data" being the string length, 1 for 
unsigned int, 2 for signed int, 19 for IPv4, 116 for progress bar, 
etc.)][data]. Let people standardize away. Am I missing the point?

I think every aspect of an OS should be intuitive (so long as it is 
efficient), which IMO /proc isn't. If this means splitting it in two, as 
some have suggested, so be it. It certainly should have a design 
guideline/spec so we may at least be consistant. Just my 2 coppers.


Will Knop
w_knop@hotmail.com

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

