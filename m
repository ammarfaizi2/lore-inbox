Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136168AbRECHp2>; Thu, 3 May 2001 03:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136170AbRECHpS>; Thu, 3 May 2001 03:45:18 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:875 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S136168AbRECHpP>; Thu, 3 May 2001 03:45:15 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kaih@khms.westfalen.de (Kai Henningsen)
cc: linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd) 
In-Reply-To: Your message of "03 May 2001 09:13:00 +0200."
             <80BTbB7Hw-B@khms.westfalen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 17:44:36 +1000
Message-ID: <13656.988875876@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 May 2001 09:13:00 +0200, 
kaih@khms.westfalen.de (Kai Henningsen) wrote:
>pavel@suse.cz (Pavel Machek)  wrote on 30.04.01 in <20010430104231.C3294@bug.ucw.cz>:
>
>> PS: Hmm, how do you do timewarp for just one userland appliation with
>> this installed?
>
>1. What on earth for?

Y10K testing :)

>2. How do you do it today, and why wouldn't that work?

LD_PRELOAD on a library that overrides gettimeofday().  I can see no
reason why that would not continue to work.  What would stop working
are timewarp modules that intercepted the syscall at the kernel level
instead of user space level.

