Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311582AbSCNKzG>; Thu, 14 Mar 2002 05:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311583AbSCNKy5>; Thu, 14 Mar 2002 05:54:57 -0500
Received: from f235.law14.hotmail.com ([64.4.21.235]:23302 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S311582AbSCNKyp>;
	Thu, 14 Mar 2002 05:54:45 -0500
X-Originating-IP: [203.115.6.248]
From: "Ishan Jayawardena" <ioshadij@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: MCE hang in 2.2.21pre4 
Date: Thu, 14 Mar 2002 10:54:38 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F23516sLtVHUR5BUlRD0001ba87@hotmail.com>
X-OriginalArrivalTime: 14 Mar 2002 10:54:39.0208 (UTC) FILETIME=[A35DFE80:01C1CB46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Something in this part broke my Mobile Pentium II (Deschutes).
>2.2.21pre3 boots fine, but 2.2.21pre4 hangs immediately after the "Intel 
>machine check architecture supported." line. gcc is 2.95.3. 2.4 and 2.5 
>kernels compiled with 2.95.3 also boot ok.

This happens to me on a celeron Mendocino (333 MHz) with _2.4.19-pre3_. GCC 
is 2.96-98 (From RH 7.2). Appending "nomce" as a boot option works around 
this, of course. The "flags" section of /proc/cpuinfo does have the "mce" 
field.

Please CC me, as I'm not on the list any more; My ISP seems to be filtering 
out everything (even majordomo) from vger.kernel.org after the attack of 
W32.myparty :(


_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

