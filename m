Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVBUW4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVBUW4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVBUW4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:56:34 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:60887 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262170AbVBUW40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:56:26 -0500
Message-ID: <421A6856.3030604@sgi.com>
Date: Mon, 21 Feb 2005 17:01:42 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mort@wildopensource.com, pj@sgi.com, linux-kernel@vger.kernel.org,
       hilgeman@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
References: <20050214154431.GS26705@localhost>	<20050214193704.00d47c9f.pj@sgi.com>	<20050221192721.GB26705@localhost>	<20050221134220.2f5911c9.akpm@osdl.org>	<421A607B.4050606@sgi.com> <20050221144108.40eba4d9.akpm@osdl.org>
In-Reply-To: <20050221144108.40eba4d9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ray Bryant <raybry@sgi.com> wrote:

>>
>>We did it this way because it was easier to get it into SLES9 that way.
>>But there is no particular reason that we couldn't use a system call.
>>It's just that we figured adding system calls is hard.
> 
> 
> aarggh.  This is why you should target kernel.org kernels first.  Now we
> risk ending up with poor old suse carrying an obsolete interface and
> application developers have to be able to cater for both interfaces.
> 

I agree, but time-to-market decisions overrode that.  Anyway, everyone
uses a program called "bcfree" to actually do the buffer-cache freeing,
so changing the interface is not as bad as all that.

Let us put something together along these lines and we will get back to you.

Thanks,
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
