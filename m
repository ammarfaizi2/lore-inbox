Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbRDKIiM>; Wed, 11 Apr 2001 04:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132535AbRDKIiE>; Wed, 11 Apr 2001 04:38:04 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:24112 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S132537AbRDKIiA>; Wed, 11 Apr 2001 04:38:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: linux-kernel@vger.kernel.org
Subject: Re: memory usage
Date: Wed, 11 Apr 2001 10:37:29 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <034201c0c1e5$adfc2b70$ae58718c@cis.nctu.edu.tw>
In-Reply-To: <034201c0c1e5$adfc2b70$ae58718c@cis.nctu.edu.tw>
MIME-Version: 1.0
Message-Id: <0104111037290D.25951@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I can use "ps" to see memory usage of daemons and user programs.
> I can't find any memory information of kernel with "top" and "ps".

> Do you know how to take memory usage information of kernel ?
> Thanks for your help.


Regarding this issue, I have a similar problem if I do a free on my system I 
get :
---   total       used       free     shared    buffers     cached
Mem:       1157444    1148120       9324          0      22080     459504
-/+ buffers/cache:     666536     490908
Swap:       641016      19072     621944
---
Now what I do a ps there seems no way to accound for the 500mb + of memory 
used. No single or group of processes uses that amount of memory. THis is 
very disconcerting, coupled with extremely high loads when cache is dumped to 
disk locking up the machine makes me want to move back to 2.2.19 from 2.4.3.

I would also be curious to see how the kernel is using memory...

TIA
MARCin


-- 
-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
