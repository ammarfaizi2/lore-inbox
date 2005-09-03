Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVICJzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVICJzd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 05:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVICJzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 05:55:33 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:30597 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750824AbVICJzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 05:55:33 -0400
Message-ID: <431972FF.6050308@gmail.com>
Date: Sat, 03 Sep 2005 11:55:11 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortel.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: looking for help tracing oops
References: <431925C4.60509@nortel.com>
In-Reply-To: <431925C4.60509@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen napsal(a):
[snip]

> EIP is at filp_close+0x64/0xa0

[snip]

> 0x00001a9a <filp_close+58>:     call   0x1a9b <filp_close+59>
> 0x00001a9f <filp_close+63>:     mov    %edi,0x4(%esp,1)
> 0x00001aa3 <filp_close+67>:     mov    %ebx,(%esp,1)

[snip]

> End of assembler dump.

It seems, that this is disassemble output of something else. The 
function pointer doesn't match.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

