Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbTHZT1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbTHZT1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:27:09 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:46819 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262981AbTHZT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:27:03 -0400
Message-ID: <3F4BB35D.6030705@namesys.com>
Date: Tue, 26 Aug 2003 23:22:05 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Oleg Drokin <green@namesys.com>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4 snapshot for August 26th.
References: <20030826102233.GA14647@namesys.com>	 <1061922037.1670.3.camel@spc9.esa.lanl.gov> <1061923101.1670.9.camel@spc9.esa.lanl.gov>
In-Reply-To: <1061923101.1670.9.camel@spc9.esa.lanl.gov>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:

>On Tue, 2003-08-26 at 12:20, Steven Cole wrote:
>  
>
>>On Tue, 2003-08-26 at 04:22, Oleg Drokin wrote:
>>    
>>
>>>Hello!
>>>
>>>   I have just released another reiser4 snapshot that I hope all interested
>>>   parties will try. It is released against 2.6.0-test4.
>>>   You can find it at http://namesys.com/snapshots/2003.08.26
>>>   I include release notes below.
>>>
>>>Reiser4 snapshot for 2003.08.26
>>>
>>>      
>>>
>>I got this error while attempting to compile with reiser4.
>>Snippet from .config follows.
>>
>>Steven
>>
>>  CC      fs/reiser4/plugin/file/tail_conversion.o
>>  CC      fs/reiser4/sys_reiser4.o
>>fs/reiser4/sys_reiser4.c:54:32: parser/parser.code.c: No such file or directory
>>    
>>
>[snipped]
>  
>
>>[steven@spc1 linux-2.6.0-test4-r4]$ grep REISER4 .config
>>CONFIG_REISER4_FS=y
>>CONFIG_REISER4_FS_SYSCALL=y
>>    
>>
>
>I should have read this more carefully :(
>
>config REISER4_FS_SYSCALL
>        bool "Enable reiser4 system call"
>        depends on REISER4_FS
>        default n
>        ---help---
>      Adds sys_reiser4() syscall.
>      This code is not in good shape yet and may not compile and stuff like that.
>
>Without REISER4_FS_SYSCALL, -test4 with reiser4 compiles fine.  Sorry about the noise.
>
>Steven
>
>
>
>
>  
>
Users should not be expected to read help text in a case like this.If it 
does not compile, it should not be visible.

-- 
Hans


