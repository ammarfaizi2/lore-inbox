Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVGVQC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVGVQC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 12:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVGVQC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 12:02:28 -0400
Received: from smtp-32.ig.com.br ([200.226.132.32]:30141 "EHLO
	smtp-32.ig.com.br") by vger.kernel.org with ESMTP id S261307AbVGVQAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 12:00:55 -0400
To: alan@lxorguk.ukuu.org.uk
From: Vinicius <jdob@ig.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel doesn't free Cached Memory
Date: Fri, 22 Jul 2005 13:00:51 -0300
X-Priority: 3 (Normal)
Message-ID: <20050722_160051_071630.jdob@ig.com.br>
X-Originating-IP: [10.17.1.76]172.31.47.254, 201.6.254.70
X-Mailer: iGMail [www.ig.com.br]
X-user: jdob@ig.com.br
Teste: asaes
MIME-Version: 1.0
Content-type: multipart/mixed;
	boundary="Message-Boundary-by-Mail-Sender-1122048051"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--Message-Boundary-by-Mail-Sender-1122048051
Content-type: text/plain; charset=ISO-8859-1
Content-description: Mail message body
Content-transfer-encoding: 8bit
Content-disposition: inline




Em (15:49:49), Alan Cox escreveu: 


>On Gwe, 2005-07-22 at 08:27 -0300, Vinicius wrote: 
>> Hi all! 
>> 
>> I have a server with 2 Pentium 4 HT processors and 32 GB of RAM, this 
>> server runs lots of applications that consume lots of memory to. When I 
>stop 
>> this applications, the kernel doesn't free memory (the memory still in 
>use) 
> 
>See any FAQ on the Linux memory management - memory is reclaimed when 
>needed not when nobody is using it. That makes things more efficient. 
> 
>> and the server cache lots of memory (~27GB). When I start this 
>applications, 
>> the kernel sends "Out of Memory" messages and kill some random 
>> applications. 
> 
>Some RHEL3 kernels had a problem with very large memory sizes and 2.4. 
>That should not be the case in the current RHEL3 kernels. 2.6 handles 
>very large systems a lot lot better, and of course the fact real 
>computers now have 64bit processors has also rather improved life. 
> 
>Alan 
> 
>---------- 

Thanks Alan, 

   I also read on the Linux-Kernel that the problem may be related to an 
exhaustion of your kernels address space, I read that the hugemem-kernel 
might be the solution to this case since it has 4GB for the kernel memory 
plus 4GB for user process. 
How can I define if my kernel memory is beeing exhausted? Does this 
exhaustion of kernel memory can cause Out Of memory errors ? 





--Message-Boundary-by-Mail-Sender-1122048051--

