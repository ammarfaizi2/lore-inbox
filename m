Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270212AbTHQO2L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 10:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270222AbTHQO2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 10:28:10 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:53182 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270212AbTHQO2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 10:28:09 -0400
Message-ID: <3F3F913D.2090005@softhome.net>
Date: Sun, 17 Aug 2003 16:29:17 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
References: <lv8Y.2XU.9@gated-at.bofh.it> <lv8Y.2XU.11@gated-at.bofh.it> <lv8Y.2XU.13@gated-at.bofh.it> <lviD.35d.3@gated-at.bofh.it> <lviD.35d.1@gated-at.bofh.it> <lvC1.3p9.11@gated-at.bofh.it>
In-Reply-To: <lvC1.3p9.11@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>
>>     I do not see how it relates to abends.
>>     It logs _everything_, what is not that useful. Having some kind of 
>>filter what to log - whould be just great. Or alternatively ability to 
>>pass file descriptor - not file name.
> 
> 
> It generates a small record for each exit, its trivial to parse the exit
> codes for exits caused by an exception.
> 

   Silly question. Related.
   Is it possible to make kernel to print oops when SIGSEGV/SIGILL is 
registered, but execution was in kernel space?
   I'm not sure about current status - but this /feature/ was advertised 
for Linux kernels: when we have a crash in kernel space e.g. in sytem 
call that calling user space application which will crash. And no notice 
about the fact, that it was actually crash inside of Linux kernel.
   Am I right or am I wrong?

