Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSHIUTP>; Fri, 9 Aug 2002 16:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSHIUTP>; Fri, 9 Aug 2002 16:19:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30983 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315760AbSHIUTL>; Fri, 9 Aug 2002 16:19:11 -0400
Message-ID: <3D542482.2080109@zytor.com>
Date: Fri, 09 Aug 2002 13:22:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: klibc development release
References: <200208092016.g79KGVk87834@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:
>>klibc is a tiny C library subset intended to be integrated into the
>>kernel source tree and being used for initramfs stuff.  Thus,
>>initramfs+rootfs can be used to move things that are currently in
>>kernel space, such as ip autoconfiguration or nfsroot (in fact,
>>mounting root in general) into user space.
> 
> Could I link 4-clause BSD source against this?
> (the GPL is incompatible with the 4-clause BSD license)
> 

I'm planning to release this under a BSD-like license, such as 3-clause
BSD, MIT or the X license.  I'm still looking at each of those.

> 
>>I would particularly appreciate portability comments, since I'm flying
>>blind on non-i386 machines (anyone want to send me hardware?),
>>although any bug reports would be appreciated.
>>
>>    ftp://ftp.kernel.org/pub/linux/libs/klibc/klibc.tar.gz
>>
>>I haven't bothered putting a version number on it, since it changes
>>quite often.  I have also published the CVS repository in the
>>directory above.
> 
> I could test on PowerPC, but wouldn't be able to tell you
> if I'm testing the latest code or not. You don't need to
> get creative with the version number; an integer is fine.
> 

Good point.

	-hpa


