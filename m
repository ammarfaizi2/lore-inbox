Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbWAGUty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbWAGUty (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 15:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWAGUty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 15:49:54 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:14388 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161096AbWAGUtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 15:49:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=dHZZxare0cMxpCkg1RLnMDbEqQmQH+6nK7ESIvljwPbOBz25nBV9VrWpIObIF+4f2ngHKKP982IdlKoMlJmq3kUr9kLrSd1NoGx5NS3a/N9yVnTNrnTKVuij/VTJwGoc/m4E3SzpSDCw8Rdnj5SwNVU9NXXTtEjz7k02OYRqjXA=
Date: Sun, 8 Jan 2006 00:06:46 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.15-mm2: alpha broken
Message-ID: <20060107210646.GA26124@mipter.zuzino.mipt.ru>
References: <20060107052221.61d0b600.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107052221.61d0b600.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alpha Just Broken (TM)
----------------------------------------------------------------------------
  CC      arch/alpha/kernel/asm-offsets.s
In file included from include/asm/user.h:5,
                 from include/linux/user.h:1,
                 from include/linux/kernel.h:16,
                 from include/linux/spinlock.h:54,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/alpha/kernel/asm-offsets.c:9:
include/linux/ptrace.h: In function `ptrace_link':
include/linux/ptrace.h:100: error: dereferencing pointer to incomplete type
include/linux/ptrace.h: In function `ptrace_unlink':
include/linux/ptrace.h:105: error: dereferencing pointer to incomplete type
make[1]: *** [arch/alpha/kernel/asm-offsets.s] Error 1

