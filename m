Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbTGDG5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 02:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbTGDG5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 02:57:51 -0400
Received: from catv-50622120.szolcatv.broadband.hu ([80.98.33.32]:1922 "EHLO
	catv-50622120.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S265812AbTGDG5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 02:57:49 -0400
Message-ID: <3F0528CF.6040703@freemail.hu>
Date: Fri, 04 Jul 2003 09:12:15 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu> <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no> <20030703141508.796e4b82.akpm@osdl.org> <20030704055315.GW26348@holomorphy.com>
In-Reply-To: <20030704055315.GW26348@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Thu, Jul 03, 2003 at 02:15:08PM -0700, Andrew Morton wrote:
>  
>
>>ok.  If you're feeling keen could you please revert the cpumask_t patch.
>>And please send the .config, thanks.
>>    
>>
>
>Zwane reproduced this and when I compiled an identical kernel for him
>it went away; the only difference wsa the compiler version.
>
>i.e. this looks like a compiler issue of some kind.
>
>Boszormenyi, Helge, could I get compiler versions? Zwane had
>
><zwane:#offtopic> gcc (GCC) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
><zwane:#offtopic> Copyright (C) 2002 Free Software Foundation, Inc.
><zwane:#offtopic> This is free software; see the source for copying conditions
>+.  There is NO
><zwane:#offtopic> warranty; not even for MERCHANTABILITY or FITNESS FOR A
>+PARTICULAR PURPOSE.
>
>so this looks like one of the offending compilers; the one I used that worked
>was:
>
>$ gcc --version
>gcc (GCC) 3.3 (Debian)
>Copyright (C) 2003 Free Software Foundation, Inc.
>This is free software; see the source for copying conditions.  There is NO
>warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
>Going over the disassemblies...
>
>
>-- wli
>
>
>
>
>  
>
Mine is:

[zozo@catv-50622120 zozo]$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/specs
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
--infodir=/usr/share/info --enable-shared --enable-threads=posix 
--disable-checking --with-system-zlib --enable-__cxa_atexit 
--host=i386-redhat-linux
Thread model: posix
gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.



