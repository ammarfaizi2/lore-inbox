Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWDKI5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWDKI5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 04:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWDKI5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 04:57:14 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:38748 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932366AbWDKI5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 04:57:13 -0400
Message-ID: <443B6F66.3020302@tls.msk.ru>
Date: Tue, 11 Apr 2006 12:57:10 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Kris Shannon <kris.shannon.kernel@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Separate Initramfs dependency on initrd (and therefore ramdisks)
References: <5d4799ae0602170820j33795815u7104bd41c7fe7e67@mail.gmail.com> <5d4799ae0604101855o72f01453l438d0d4d628bbb7@mail.gmail.com>
In-Reply-To: <5d4799ae0604101855o72f01453l438d0d4d628bbb7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kris Shannon wrote:
> A number of distributions (most importantly for me - Debian) use the
> initrd as initramfs facility.  I assumed that the passing of the data
> block would be independent of ram disks seeing as not using a ram
> disk was one of the major reasons for initramfs,  but it seems that
> you need CONFIG_BLK_DEV_INITRD=y which depends on
> CONFIG_BLK_DEV_RAM=y
> 
> Would a patch separating out the init image handling from the initrd
> handling be welcome and if so should the resulting init image code
> be dependant on a CONFIG variable or always on (like initramfs is now)
> 
> The only reference to this I found in the archives was:
> 
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0508.1/0097.html

http://www.ussg.iu.edu/hypermail/linux/kernel/0603.1/0969.html

/mjt
