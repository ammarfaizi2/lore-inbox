Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWEUVmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWEUVmm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 17:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWEUVmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 17:42:42 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:21393 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S964937AbWEUVml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 17:42:41 -0400
Message-ID: <4470DEC4.6050308@vilain.net>
Date: Mon, 22 May 2006 09:42:28 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Linux Kernel Source Compression
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605212003.32063.s0348365@sms.ed.ac.uk> <20060521210056.GA3500@taniwha.stupidest.org>
In-Reply-To: <20060521210056.GA3500@taniwha.stupidest.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>On Sun, May 21, 2006 at 08:03:32PM +0100, Alistair John Strachan wrote:
>
>  
>
>>Somebody needs to make lzma userspace tools (like p7zip) faster, not
>>crash, and behave like a regular UNIX program. Then we need a patch
>>to GNU tar to emerge, and for it to persist for at least 4
>>years. Then maybe people will adopt this format..
>>    
>>
>
>why?
>
>the gains aren't that great
>

Exactly, and while I know my network connection isn't exactly
representative of the general population of people building the kernel,
it's currently faster for me to download and unpack a .gz than to wait
the extra time for bzip2 to decompress. I've always found it quicker
dealing with .gz's for incremental patches. I thought the speed issue is
more of a speed / compression ratio trade-off, ie a caveat of
compression in general.

Mind you, 'git fetch' is even faster, even for people who aren't close
enough to their mirror to fetch a full .gz kernel tarball in <5s.

Sam.
