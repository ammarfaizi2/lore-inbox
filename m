Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVAQEMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVAQEMx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 23:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVAQEMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 23:12:53 -0500
Received: from mail.tmr.com ([216.238.38.203]:25298 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262690AbVAQEMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 23:12:48 -0500
Message-ID: <41EB3E7E.7070100@tmr.com>
Date: Sun, 16 Jan 2005 23:26:38 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jari Ruusu <jariruusu@users.sourceforge.net>
CC: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
References: <41EAE36F.35354DDF@users.sourceforge.net>
In-Reply-To: <41EAE36F.35354DDF@users.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:
> loop-AES changes since previous release:
> - Fixed externally compiled module version multi-key-v3 ioctl
>   incompatibility with boxes running 64 bit kernel and 32 bit userland.
>   Kernel patch versions were not affected (2.4 and 2.6 kernels).
> - Fixed bug that made v3 on-disk format always use file backed code path on
>   some 2.6 kernels that did not have LO_FLAGS_DO_BMAP defined. No data loss,
>   but file backed code path is not journaled file system safe. Same bug also
>   had cosmetic side effect of "losetup -a" status query always displaying
>   file backed v2 on-disk format as v3 on-disk format.
> 
> bzip2 compressed tarball is here:
> 
>     http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.0b.tar.bz2
>     md5sum b295ff982cd4503603b38fdc54e604cc
> 
>     http://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.0b.tar.bz2.sign
> 

Is this eventually going in the mainline kernel? I'd like to use it, but 
if I'm going to have to maintain my own crypto kernels indefinitely this 
probably isn't the one for me.
-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
