Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVJXR7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVJXR7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVJXR7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:59:47 -0400
Received: from smtpout.mac.com ([17.250.248.86]:49897 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751204AbVJXR7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:59:46 -0400
In-Reply-To: <1130171073.6831.6.camel@localhost.localdomain>
References: <20051022231214.GA5847@us.ibm.com> <200510230922.26550.ioe-lkml@rameria.de> <20051023143617.GA7961@us.ibm.com> <200510232055.17782.ioe-lkml@rameria.de> <20051023120521.26031051.akpm@osdl.org> <20051024004709.GA9454@us.ibm.com> <1130171073.6831.6.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5D5AD6EA-5D6E-47DA-8170-0729F9C32889@mac.com>
Cc: paulmck@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Ingo Oeser <ioe-lkml@rameria.de>, lkml <linux-kernel@vger.kernel.org>,
       arjan@infradead.org, pavel@ucw.cz, dipankar@in.ibm.com,
       vatsa@in.ibm.com, rusty@au1.ib.com, mingo@elte.hu,
       manfred@colorfullife.com, gregkh@kroah.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] RCU torture-testing kernel module
Date: Mon, 24 Oct 2005 13:59:30 -0400
To: Badari Pulavarty <pbadari@gmail.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 24, 2005, at 12:24:33, Badari Pulavarty wrote:
> Paul,
>
> I enabled RCU_TORTURE_TEST in 2.6.14-rc5-mm1. My machine took 10+  
> minutes to boot and let me login. RCU kthreads are hogging the  
> CPU.  Is this expected ?

Uhh...  It's a torture test.  What exactly do _you_ expect it will  
do?  I think the idea is to enable it as a module and load it when  
you want to start torture testing, and unload it when done.   
"TORTURE_TEST"s are not for production systems :-D.


Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------



