Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131789AbRBWTWh>; Fri, 23 Feb 2001 14:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbRBWTW1>; Fri, 23 Feb 2001 14:22:27 -0500
Received: from raven.toyota.com ([63.87.74.200]:60677 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S131789AbRBWTWN>;
	Fri, 23 Feb 2001 14:22:13 -0500
Message-ID: <3A96B861.920E5A57@toyota.com>
Date: Fri, 23 Feb 2001 11:22:09 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Tim <timikpoket@yahoo.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem with mount -o loop
In-Reply-To: <20010223191415.5746.qmail@web1305.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Tim wrote:

> I made iso-image from cd with
>   dd if=/dev/hdd of=/image.iso
> and mount it with
>   mount -o loop /image.iso /mnt/cdrom
> under Linux-2.4.2-pre1 it is working
> but under Linux-2.4.2 do not
> Please help me to understand why

If it was working it was by sheer luck -

You need the loop patches available at

ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches

jjs

