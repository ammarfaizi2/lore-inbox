Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbTFSGcg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbTFSGcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:32:36 -0400
Received: from terminus.zytor.com ([63.209.29.3]:25834 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265706AbTFSGce
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:32:34 -0400
Message-ID: <3EF15C41.2020908@zytor.com>
Date: Wed, 18 Jun 2003 23:46:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org
Subject: Re: common name for the kernel DSO
References: <16112.47509.643668.116939@napali.hpl.hp.com>	<bcrkiq$dta$1@cesium.transmeta.com> <16113.22348.748334.416581@napali.hpl.hp.com>
In-Reply-To: <16113.22348.748334.416581@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On 18 Jun 2003 23:18:02 -0700, "H. Peter Anvin" <hpa@zytor.com> said:
> 
> 
>   HPA> It's a pretty ugly name, quite frankly, since it doesn't explain what
>   HPA> it is a gate from or to.  linux-syscall.so.1 or linux-kernel.so.1
>   HPA> would make a lot more sense.
> 
> Umh, it does say _linux_-gate, so I think it's pretty
> self-explanatory.  I considered linux-kernel.so, but think it would
> cause a lot of confusion vis-a-vis, say, kernel32.dll (I didn't write
> that, did I??).  I'm not terribly fond of linux-syscall, but I could
> live with it.
> 

There is a lot of "linux" in userspace too, though.  ld-linux.so.* to 
start out with...

	-hpa


