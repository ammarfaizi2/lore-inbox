Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278396AbRJSNVm>; Fri, 19 Oct 2001 09:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278400AbRJSNVc>; Fri, 19 Oct 2001 09:21:32 -0400
Received: from conx.aracnet.com ([216.99.200.135]:12538 "HELO cj90.in.cjcj.com")
	by vger.kernel.org with SMTP id <S278396AbRJSNVW>;
	Fri, 19 Oct 2001 09:21:22 -0400
Message-ID: <3BD028C8.20602@cjcj.com>
Date: Fri, 19 Oct 2001 06:21:12 -0700
From: cj <cj@cjcj.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark van Walraven <markv@wave.co.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10 etherboot initrd init= problem
In-Reply-To: <3BB0958B.8030703@cjcj.com> <20011011132047.A401@bee.lk> <20011019131913.A596@mail.wave.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's it!  Thank you very much.  A thousand thanks.

Mark van Walraven wrote:

>On Tue, Sep 25, 2001 at 07:32:43AM -0700, cj wrote:
>
>>Kernel panic: No init found.  Try passing init= option to kernel.
>>
>>These kernel command lines work with 2.4.9 but not 2.4.10:
>>auto rw root=/dev/ram ramdisk_size=8192
>>auto rw root=/dev/ram init=/sbin/init ramdisk_size=8192
>>auto rw root=/dev/ram init=/bin/ash ramdisk_size=8192
>>
>
>Are the execute permission bits set for /lib/ld-* in your initrd?
>
>Mark.
>
>


