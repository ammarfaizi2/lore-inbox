Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWCSBms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWCSBms (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 20:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWCSBms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 20:42:48 -0500
Received: from out-mta2.ai270.net ([83.244.130.113]:28353 "EHLO
	out-mta1.ai270.net") by vger.kernel.org with ESMTP id S1751199AbWCSBmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 20:42:47 -0500
In-Reply-To: <20060317203904.GE21493@w.ods.org>
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk> <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060317203904.GE21493@w.ods.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1D707D43-5AAF-4265-891A-04EFDA060E53@lougher.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Phillip Lougher <phillip@lougher.org.uk>
Subject: Re: [ANN] Squashfs 3.0 released
Date: Sun, 19 Mar 2006 01:38:56 +0000
To: Willy Tarreau <willy@w.ods.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2006, at 20:39, Willy Tarreau wrote:

> Hi,
>
> On Fri, Mar 17, 2006 at 12:25:44PM -0500, Jeff Garzik wrote:
>> I have two routers, ADM5120-based Edimax and LinkSys WRT54G v5,  
>> both of
>> which have a mere 2MB of flash, and both use SquashFS to maximize  
>> that
>> space.  And both are el cheapo, slow embedded processors that run far
>> slower than 300Mhz.  I look askance at anyone who wants to make an
>> arbitrary filesystem design decision imposing tons of bytesex upon  
>> these
>> lowly devices.
>
> 100% agreed. I love squashfs because it's tiny and efficient, and I
> would not want to see it getting heavy.
>

Thanks!  I'm determined to keep Squashfs as small/efficient as  
possible, as that's where I see its main advantages.

> BTW, has someone tried to port LZMA to squashfs ? I tried so on
> bzImage + initramfs, and got something like a 27% smaller image.
> That would mean about 500 kB on a 2 MB image.
>

There are quite a few third-party LZMA patches for Squashfs.  OpenWRT  
(for wifi routers) uses an LZMA patched Squashfs.

I've been asked about using LZMA for Squashfs quite a few times.   
The  major problem as I see it with LZMA is it is not supported by  
the Linux kernel, and I don't want to use anything that might prevent  
it being merged!  At the moment I'm happy with the current situation  
where there's third party patches available for those that want or  
need it.  Of course if the situation changed with LZMA going into the  
Linux kernel, then I'd see no problem in using it in Squashfs.

Phillip

