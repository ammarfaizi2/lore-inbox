Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313512AbSD3NPM>; Tue, 30 Apr 2002 09:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313509AbSD3NPL>; Tue, 30 Apr 2002 09:15:11 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:54524 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S313512AbSD3NPH>; Tue, 30 Apr 2002 09:15:07 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200204301300.g3UD0mX02997@Port.imtp.ilyichevsk.odessa.ua> 
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to enable printk 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Apr 2002 14:14:53 +0100
Message-ID: <23722.1020172493@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vda@port.imtp.ilyichevsk.odessa.ua said:
>  Hey, hey... do you expect users to patch all those printk() calls  in
> their kernel themself? Realistically they can:

I was talking about vendors setting silly defaults. One can reasonably
expect _vendors_ to fix printks with wrong or no priority rather than just
disabling them all.

There's a lot of crap at KERN_NOTICE that could be sanely ignored by
default. Stuff at KERN_WARNING probably ought to be printed by default. It
can often precede and explain a crash.

> * send patches to lkml and be ignored

There are more sensible places to send patches than lkml. 

--
dwmw2


