Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbUK1NZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbUK1NZR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 08:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUK1NZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 08:25:16 -0500
Received: from hermes.domdv.de ([193.102.202.1]:55569 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261465AbUK1NZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 08:25:11 -0500
Message-ID: <41A9D1A4.8090805@domdv.de>
Date: Sun, 28 Nov 2004 14:24:52 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Sam Ravnborg <sam@ravnborg.org>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       dwmw2@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <20041127211923.GA21765@mars.ravnborg.org> <41A8F67E.1060908@domdv.de> <200411280021.51574.arnd@arndb.de>
In-Reply-To: <200411280021.51574.arnd@arndb.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
>>#ifdef __x86_64__
>>#include <asm-x86_64/byteorder.h>
>>#else
>>#include <asm-i386/byteorder.h>
>>#endif
>>
> 
> 
> I think we can get rid of this hack when we move to split kernel headers.
> parisc, s390 and mips already have combined headers, and it should not be
> too hard to combine the user ABI headers for sparc, ppc and x86_64 as well,
> without having to merge the complete architecture and kernel header trees
> for them.
> 

If you can produce merged x86/x86_64 ABI headers this would be a nice 
solution.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
