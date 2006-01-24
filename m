Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWAXPPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWAXPPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWAXPPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:15:12 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:40362 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030353AbWAXPPK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:15:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VeVVOnqWNSHupPEzdk0+VTezQiLlLT/iR2ZOkdVaXJTt+WXS9FFKQCoP8DU7bVnUlG8Z+1dilqFGc8siVvVo1clgjt+e7tOQgpFADug1z443TsUQKOx5MMc1BYw4lyfYqbPegRffrdkUENabxdRGa9/ZSlic5be+4rTaxLLwx/I=
Message-ID: <7c3341450601240715n3af86efbl@mail.gmail.com>
Date: Tue, 24 Jan 2006 15:15:06 +0000
From: Nick <nick@linicks.net>
Reply-To: Nick <nick@linicks.net>
To: Andy Spiegl <kernelbug.Andy@spiegl.de>, John Stoffel <john@stoffel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.15 crashes X Server after running OpenGL programs
In-Reply-To: <20060124142151.GA3538@spiegl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124121542.GB13646@spiegl.de>
	 <17366.13811.386903.438419@smtp.charter.net>
	 <20060124142151.GA3538@spiegl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/06, Andy Spiegl <kernelbug.Andy@spiegl.de> wrote:
> > Talk to ATI, it's their code doing something wrong.
> Okay, knowing that for sure already helped me.
>
> I thought that it's a bug in the kernel source because syslog says
> "kernel BUG at mm/swap.c" and swap.c isn't part of fglrx.
>
> Too bad there is no free OpenGL driver - I hate to use closed source stuff.

There is something funny with your build - from the syslog:

Jan 13 11:51:43 condor kernel: Symbols match kernel version 2.6.15.
Jan 13 11:51:43 condor kernel: No module symbols loaded - kernel
modules not enabled.

So how can you use modules?

Nick
