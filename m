Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbUK3KcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbUK3KcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 05:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUK3KcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 05:32:16 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:50683 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262036AbUK3Kb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 05:31:59 -0500
Message-ID: <41AC4C1D.1050102@mvista.com>
Date: Tue, 30 Nov 2004 02:31:57 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: A problem with xconfig
References: <41ABA8E5.4060504@mvista.com> <20041130052824.GA8211@mars.ravnborg.org>
In-Reply-To: <20041130052824.GA8211@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, Nov 29, 2004 at 02:55:33PM -0800, George Anzinger wrote:
> 
>>In looking at the makefile history, it would appear that libkconfig.so has 
>>been deleted from the build.  It seems, however, that qconf has not gotten 
>>the message:
>>
>> make O=/usr/src/ver/makena/obj/  xconfig ARCH=i386
>>  HOSTCXX scripts/kconfig/qconf.o
>>  HOSTLD  scripts/kconfig/qconf
>>scripts/kconfig/qconf arch/i386/Kconfig
>>./scripts/kconfig/libkconfig.so: cannot open shared object file: No such 
>>file or directory
>>make[2]: *** [xconfig] Error 1
>>make[1]: *** [xconfig] Error 2
>>make: *** [xconfig] Error 2
> 
> 
> It used to be so but was addressed in a patch to scripts/kconfig/Makefile
> a few weeks ago. Do you see it with latest -linus / -mm?

Gosh, did I do that.  Forgot to say it was the 2.6.9 kernel.  Am I the only one 
using xconfig??
>
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

