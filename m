Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSEFLjT>; Mon, 6 May 2002 07:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSEFLjS>; Mon, 6 May 2002 07:39:18 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:44559 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313419AbSEFLjQ>; Mon, 6 May 2002 07:39:16 -0400
Message-ID: <3CD66A0F.4020302@namesys.com>
Date: Mon, 06 May 2002 15:33:35 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver.Schersand@BASF-IT-Services.com
CC: chris.mason@suse.com, alessandro.suardi@oracle.com, sbrand@mainz.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Review: Servercrash with kernel SuSE 2.4.16
In-Reply-To: <OF10FE0462.9B5B7937-ONC1256BB1.002ADC0F@bcs.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver.Schersand@BASF-IT-Services.com wrote:

>Hi,
>
>This is the actual result of the analys of our oracle server crashes on
>linux servers with suse Enterprise Server 7 and Kernel 2.4.16
>
>The reason for theses crashes where  the compaq remote inside and compaq
>health drivers. These drivers are deliverd from compaq. On stardup of these
>agents, they load binary kernel modules, which are very version sensitive.
>This modules  corrupt the virtual memory management of the server on heavy
>load
>
>This shows us a main problem of Linux in datacenter environment. The
>automatic guarding of the local attached storage and the hardware is very
>importend in this environments. In this environment we use expensive high
>performance hardware. These hardware is not  good  supported by the
>standard linux kernel. The companies which sell these hardware deliver not
>all features of these hardware to the community of linux.  There drivers
>and guarding agents are not distributed under GPL.
>
>
>Here is the statement of Compaq ( HPQ)
>
>   The new health driver that can be run on any re-compiled kernel is due
>   out in the SmartStart 5.50 timeframe (3Q02).  The reason for this is
>   that it also provides support for new servers as well.
>   The delivery method will be via the Compaq web site and the SmartStart
>   Cd.
>
>   The customer expectation is that it will work with any re-compiled
>   kernel.  Most likely that will be true however it will be impossible for
>   us to validate it with every possibility due to the open source nature
>   of Linux.
>
Well, if they supplied the source code then customers could validate it 
and fix it.;-)

>
>   Today, customers actually can run the existing health driver on
>   re-compiled kernels by evoking a "fix-up" script that will be available
>   on our website.  This is not an ideal solution but it will work in a
>   majority of the situations.
>
>
>Thank you very much for all the help with this problem
>
>Oliver Schersand
>
>
>
>  
>

I think that any product which lacks source code is unsuited for use in 
a mission-critical Linux server application.  I think customers should 
tell companies this.  When things break, you need to be able to fix 
them, and not listen to excuses about how it is somehow the customer's 
fault that they used a version of Linux that works except for the 
vendor's code.  The paradigm has changed.....

You have my sympathies.  I will restrain myself from telling you about 
buying a Dell laptop, and having customer service tell me that they 
would not provide me any support unless I installed the original 
(windows) OS when I had a clearly hardware problem.....

I should have bought IBM and waited 4-6 weeks for their incompetent 
(incompetent only in that they take too long to ship) shipping 
department to build and send me my laptop....

Hans

