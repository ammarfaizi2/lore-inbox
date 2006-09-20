Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWITPYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWITPYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 11:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWITPYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 11:24:42 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:15811 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751600AbWITPYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 11:24:41 -0400
Date: Wed, 20 Sep 2006 11:22:57 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Mitch@0Bits.COM
Cc: linux-kernel@vger.kernel.org
Subject: Re: UML build failure with 2.6.18
Message-ID: <20060920152257.GA4672@ccure.user-mode-linux.org>
References: <Pine.LNX.4.63.0609201724320.29128@hasbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609201724320.29128@hasbox.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
