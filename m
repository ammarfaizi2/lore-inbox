Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUJSDdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUJSDdK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 23:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUJSDdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 23:33:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34181 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267904AbUJSDc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 23:32:58 -0400
Message-ID: <41748ADE.70403@pobox.com>
Date: Mon, 18 Oct 2004 23:32:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.9 BK build broken
References: <20041019021719.GA22924@merlin.emma.line.org> <41747CA6.7030400@pobox.com>
In-Reply-To: <41747CA6.7030400@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Matthias Andree wrote:
>> $ LANG=C make CC=/opt/gcc-3.4/bin/gcc
>> ...
>>   LDS     arch/i386/kernel/vsyscall.lds
>>   AS      arch/i386/kernel/vsyscall-int80.o
>>   SYSCALL arch/i386/kernel/vsyscall-int80.so
>>   AS      arch/i386/kernel/vsyscall-sysenter.o
>>   SYSCALL arch/i386/kernel/vsyscall-sysenter.so
>>   AS      arch/i386/kernel/vsyscall.o
>> In file included from include/linux/init.h:5,
>>                  from arch/i386/kernel/vsyscall.S:1:
>> include/linux/compiler.h:20: syntax error in macro parameter list
>> make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
>> make: *** [arch/i386/kernel] Error 2
> 
> 
> 
> I get an ICE here in -BK-latest, which the attached patch fixes (backs 
> out Linus's change).


Another data point, I have no problems with 2.6-BK-latest on x86-64, 
with gcc 3.3.3 (FC2)...

	Jeff


