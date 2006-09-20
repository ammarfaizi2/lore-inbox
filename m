Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWITPbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWITPbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 11:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWITPbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 11:31:32 -0400
Received: from [80.227.95.181] ([80.227.95.181]:33730 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S1751583AbWITPbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 11:31:31 -0400
Message-ID: <45115EC7.2010407@0Bits.COM>
Date: Wed, 20 Sep 2006 19:31:19 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Thunderbird 3.0a1 (X11/20060912)
MIME-Version: 1.0
To: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: UML build failure with 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's no distro (built up myself, so you can assume a gentoo type build).
I'm building from scratch, so it should use no headers since i'm 
building a kernel.

-------- Original Message --------
Subject: Re: UML build failure with 2.6.18
Date: Wed, 20 Sep 2006 11:22:57 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Mitch@0Bits.COM
CC: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0609201724320.29128@hasbox.com>

On Wed, Sep 20, 2006 at 05:27:12PM +0400, Mitch@0Bits.COM wrote:
> anyone having UML build failure with the shiny new 2.6.18

>    CC      arch/um/os-Linux/process.o
> arch/um/os-Linux/process.c:144: error: syntax error before 'getpid'
> arch/um/os-Linux/process.c:146: warning: return type defaults to 'int'
> arch/um/os-Linux/process.c:146: warning: function declaration isn't a
> prototype
> arch/um/os-Linux/process.c: In function '_syscall0':
> arch/um/os-Linux/process.c:147: error: syntax error before '{' token
> arch/um/os-Linux/process.c:162: error: syntax error before 'prot'
> arch/um/os-Linux/process.c:209: error: parameter 'ok' is initialized
> arch/um/os-Linux/process.c:211: error: syntax error before 'printk'
> arch/um/os-Linux/process.c:279: error: syntax error before '*' token
> make[1]: *** [arch/um/os-Linux/process.o] Error 1
> make: *** [arch/um/os-Linux] Error 2

What's the host distro?

I just built (plus the jmmpbuf patch, which isn't the problem here)
and booted it, and it seems fine here.

				Jeff
