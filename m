Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbTGANXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 09:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTGANXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 09:23:38 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:525 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S262318AbTGANXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 09:23:37 -0400
Message-ID: <3F018F7A.3050301@techsource.com>
Date: Tue, 01 Jul 2003 09:41:14 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Fredrik Tolf <fredrik@dolda2000.cjb.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PTY DOS vulnerability?
References: <200306301613.11711.fredrik@dolda2000.cjb.net>	 <1056995729.17590.19.camel@dhcp22.swansea.linux.org.uk>	 <200306302331.38071.fredrik@dolda2000.cjb.net> <1057008994.17589.40.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about giving each user his own set of virtual ptys?

Alan Cox wrote:
> On Llu, 2003-06-30 at 22:31, Fredrik Tolf wrote:
> 
>>That is true, though, of course. Stupid me not to think about 
>>that. However, that means that an administrator who could find 
>>himself being under such an attack might not think about it 
>>either. Also, from the outside, the ssh client just does 
>>nothing, making it look as if the server is unresponsive. Of 
>>course, the exact error is logged to the server's syslog, but if 
>>you can't view it, then you won't know about it.
>>
>>So all in all, do you think I should implement a per-user 
>>resource limit on PTYs?
> 
> 
> There are a whole collection of things that would benefit from that kind
> of management - go for it but make it possible to add other stuff too
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


