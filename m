Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTDGDS5 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbTDGDS5 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:18:57 -0400
Received: from dp.samba.org ([66.70.73.150]:25029 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263215AbTDGDSz (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:18:55 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16016.57974.167579.753484@argo.ozlabs.ibm.com>
Date: Mon, 7 Apr 2003 12:29:10 +1000
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC
In-Reply-To: <20030407024858.C32422C014@lists.samba.org>
References: <20030407024858.C32422C014@lists.samba.org>
X-Mailer: VM 7.14 under Emacs 21.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:

> Paul, is this OK?
> 
> I'd like it in 2.4.21 if possible.

Looks good, I'd like it too.

Just one comment: 

> +Kernel support for Linux/Intel ELF binaries
> +CONFIG_X86_EMU
> +  Say Y here if you want to be able to execute Linux/Intel ELF
> +  binaries just like native binaries on your PPC machine. For
> +  this to work, you need to have /usr/gnemul/x86-linux populated
> +  with Intel libraries. etc.
> +
> +  You may answer M to compile the emulation support as a module and
> +  later load the module when you want to use a Linux/Intel binary. The
> +  module will be called x86emu.o.  If unsure, say Y.
> +

This should say that you need qemu as well, and it should probably
include the URL to Fabrice's qemu web page.

Paul.
