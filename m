Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVDRTUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVDRTUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVDRTUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 15:20:04 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:58530 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262170AbVDRTT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 15:19:59 -0400
Message-ID: <42640856.4060203@ammasso.com>
Date: Mon, 18 Apr 2005 14:19:50 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Terje Malmedal <tm@basefarm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
References: <6533c1c905041511041b846967@mail.gmail.com>	<1113588694.6694.75.camel@laptopd505.fenrus.org>	<6533c1c905041512411ec2a8db@mail.gmail.com>	<e1e1d5f40504151251617def40@mail.gmail.com>	<6533c1c905041512594bb7abb4@mail.gmail.com>	<Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>	<6533c1c905041807487a872025@mail.gmail.com>	<1113836378.6274.69.camel@laptopd505.fenrus.org>	<6533c1c9050418080639e41fb@mail.gmail.com>	<1113837657.6274.74.camel@laptopd505.fenrus.org> <wvhis2jewxh.fsf@cornavin.basefarm.no>
In-Reply-To: <wvhis2jewxh.fsf@cornavin.basefarm.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Malmedal wrote:

>   Every so often there is bug in the kernel, by patching the
>   syscall-table I have been able to fix bugs in ioperm and fsync without
>   rebooting the box. 
> 
>   What do I do the next time I need to do something like this? 

Nothing.

You have to understand that the kernel developers don't want to add support for doing 
things the "wrong way", even if the "wrong way" is more convenient for YOU.  In the long 
wrong, the "wrong way" will cause more trouble than it saves.

Fixing kernels bugs without rebooting the computer is not something that the kernel 
developers want to support.  Besides, that sounds like a ridiculous thing to do, anyway. 
I don't see how anyone can reasonably expect any OS to handle that.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
