Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSFHKN6>; Sat, 8 Jun 2002 06:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSFHKN5>; Sat, 8 Jun 2002 06:13:57 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:51177 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317387AbSFHKN5>; Sat, 8 Jun 2002 06:13:57 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Michael De Nil <linux@aerythmic.be>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: /dev/input/mice problem with 2.4.19-pre9 & 10
Date: Sat, 8 Jun 2002 20:11:07 +1000
User-Agent: KMail/1.4.5
In-Reply-To: <Pine.LNX.4.44.0206081137310.32319-100000@LiSa>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206082011.07170.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2002 19:41, Michael De Nil wrote:
> hey
>
> I saved the old config from 2.4.18 (with make menuconfig) and loaded it
> with kernel 2.4.19-pre9 and pre10. everything compiles etc, the kernel
> boots, but my usb-mouse is not working any more ...
This probably should tell you that what you've done is a silly thing: 
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101761858728615&w=2

If you'd done a make oldconfig, you'd have seen the new option for 
CONFIG_USB_HIDINPUT. 

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
