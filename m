Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbTAGIFp>; Tue, 7 Jan 2003 03:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbTAGIFp>; Tue, 7 Jan 2003 03:05:45 -0500
Received: from f39.sea1.hotmail.com ([207.68.163.39]:29971 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267338AbTAGIFo>;
	Tue, 7 Jan 2003 03:05:44 -0500
X-Originating-IP: [196.44.34.77]
From: "Dirk Bull" <dirkbull102@hotmail.com>
To: fork0@users.sf.net, doug@mcnaught.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmat problem
Date: Tue, 07 Jan 2003 08:14:17 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F39ekoL0jfQnPEiuGHi0001ee0c@hotmail.com>
X-OriginalArrivalTime: 07 Jan 2003 08:14:18.0000 (UTC) FILETIME=[C6316900:01C2B624]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your help. I also thought the memory mapping code I'm
porting looked funny. The code forms part of a simulation program where a 
few processes have to share data in a data base. In the code they(the 
original implementers) initialize a bunch of variables and then share these 
variables as I've shown you. I've referenced W.R Stevens's UNIX programming 
books and found no information on whether you could share memory other than 
that on the heap (did not want to change their code to use pointers, not a 
good idea to change too much of the original code). To end a long story, 
Alex, thanks for the SHM_REMAP flag, would never have found it, you've saved 
me a lot of time. Finally, in the code they share pages, therefor using 
SHM_REMAP is not that unsafe, but still not good practice?

Thanks again.

Dirk









_________________________________________________________________
Help STOP SPAM: Try the new MSN 8 and get 2 months FREE* 
http://join.msn.com/?page=features/junkmail

