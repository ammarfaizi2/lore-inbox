Return-Path: <linux-kernel-owner+w=401wt.eu-S1422777AbXAMUVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbXAMUVQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 15:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422776AbXAMUVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 15:21:16 -0500
Received: from mail.tmr.com ([64.65.253.246]:43136 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422777AbXAMUVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 15:21:15 -0500
Message-ID: <45A93FA4.9050600@tmr.com>
Date: Sat, 13 Jan 2007 15:23:00 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Jeff Chua <jeff.chua.linux@gmail.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.20-rc5
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>	 <20070112142645.29a7ebe3.akpm@osdl.org>	 <b6a2187b0701121936t3175d7a1i21eb6fa1f72cac1d@mail.gmail.com> <b6a2187b0701121944j702ba941s1cc0583e476ceb6a@mail.gmail.com>
In-Reply-To: <b6a2187b0701121944j702ba941s1cc0583e476ceb6a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> On 1/13/07, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>> On 1/13/07, Andrew Morton <akpm@osdl.org> wrote:
>> > On Fri, 12 Jan 2007 14:27:48 -0500 (EST)
>> > Linus Torvalds <torvalds@osdl.org> wrote:
>>
>>   CC [M]  drivers/kvm/vmx.o
>> {standard input}: Assembler messages:
>> {standard input}:3257: Error: bad register name `%sil'
>> make[2]: *** [drivers/kvm/vmx.o] Error 1
>> make[1]: *** [drivers/kvm] Error 2
>> make: *** [drivers] Error 2
>>
>> Am I missing something or this is a real problem?
>> Applied 2.6.20-rc5-mm-fixes and got this problem.
>> Using gcc version 3.4.5, binutils-2.17.50.0.8
> 
> Same problem with vanilla linux-2.6.20-rc5.

What target? I had no such problem with x86, haven't tried the x86_64 
build yet. Haven't even been able to try a boot, but the build was fine ;-)

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
