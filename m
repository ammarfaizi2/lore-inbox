Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUCWLTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbUCWLTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:19:50 -0500
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:52040 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262488AbUCWLTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:19:48 -0500
Message-ID: <40601D54.1040305@blueyonder.co.uk>
Date: Tue, 23 Mar 2004 11:19:48 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm1
References: <405F8DFB.1010801@blueyonder.co.uk>
In-Reply-To: <405F8DFB.1010801@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2004 11:19:47.0578 (UTC) FILETIME=[C01BFDA0:01C410C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Strange, cross checked with entry.S for 2.6.4-mm1 and 2.6.5-rc1 and they 
all seem to be the same in the lines complained about.
# gcc -v
Reading specs from /usr/lib64/gcc-lib/x86_64-suse-linux/3.3.1/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --info
dir=/usr/share/info --mandir=/usr/share/man --libdir=/usr/lib64 
--enable-languages=c,c++,f77,objc,java,a
da --disable-checking --enable-libgcj 
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib64 --wi
th-system-zlib --enable-shared --enable-__cxa_atexit x86_64-suse-linux
Thread model: posix
gcc version 3.3.1 (SuSE Linux)
Regards
Sid.

Sid Boyce wrote:

> No response so far to the following.
> Regards
> Sid.
>
>
> ------------------------------------------------------------------------
>
> Subject:
> RE: 2.6.5-rc2-mm1 x86_64 entry.S errors
> From:
> Sid Boyce <sboyce@blueyonder.co.uk>
> Date:
> Sun, 21 Mar 2004 18:24:51 +0000
> To:
> linux-kernel@vger.kernel.org
>
> To:
> linux-kernel@vger.kernel.org
>
>
>  AS      arch/x86_64/kernel/entry.o
> arch/x86_64/kernel/entry.S: Assembler messages:
> arch/x86_64/kernel/entry.S:184: Error: missing separator
> arch/x86_64/kernel/entry.S:434: Error: missing separator
> arch/x86_64/kernel/entry.S:551: Error: missing separator
> arch/x86_64/kernel/entry.S:554: Error: missing separator
> arch/x86_64/kernel/entry.S:557: Error: missing separator
> arch/x86_64/kernel/entry.S:719: Error: missing separator
> arch/x86_64/kernel/entry.S:778: Error: missing separator
> arch/x86_64/kernel/entry.S:806: Error: missing separator
> arch/x86_64/kernel/entry.S:819: Error: missing separator
> arch/x86_64/kernel/entry.S:872: Error: missing separator
> arch/x86_64/kernel/entry.S:888: Error: missing separator
> arch/x86_64/kernel/entry.S:912: Error: missing separator
> make[1]: *** [arch/x86_64/kernel/entry.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2
> Regards
> Sid.
>


-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

