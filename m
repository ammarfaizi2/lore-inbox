Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312931AbSDCAiQ>; Tue, 2 Apr 2002 19:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312935AbSDCAiG>; Tue, 2 Apr 2002 19:38:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:64135 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S312931AbSDCAiB>;
	Tue, 2 Apr 2002 19:38:01 -0500
Message-ID: <3CAA4EE1.1060502@gmx.net>
Date: Wed, 03 Apr 2002 02:37:53 +0200
From: =?ISO-8859-1?Q?Andreas_M=F6ller?= <andreas-moeller@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020402 Debian/2:0.9.9-4
X-Accept-Language: de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: -aa VM splitup
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    I have patched a stock 2.4.19-pre5 kernel with Andrew Morton's -aa 
VM splitup [1], Ingo Molnar's O(1) scheduler [2], Andrew Morton's read 
latency [3] and IDE lockup patches [4] and the mini low latency patch 
[5] plus fixes for it [6] (in this order). When running ps or top under 
this kernel, I get following error messages:

{vmalloc_to_page} {GPLONLY_vmalloc_to_page}
Warning: /boot/System.map does not match kernel data.

I made sure that I didn't forget to copy the new System.map. Perhaps 
some symbol needs to be exported?

        Andreas

--
[1] http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre5/aa1/
[2] 
http://people.redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.18-pre8-K3.patch
[3] 
http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre5/read-latency2.patch
[4] 
http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre5/ide-lockup.patch
[5] 
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre5-jam2/23-lowlatency-mini.gz
[6] 
http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre5-jam2/24-lowlatency-fixes-5.gz

