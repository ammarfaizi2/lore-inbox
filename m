Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266322AbUGAWTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbUGAWTF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266328AbUGAWTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:19:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:35035 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266339AbUGAWTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:19:00 -0400
Date: Thu, 1 Jul 2004 15:21:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: azarah@nosferatu.za.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: binutils woes
Message-Id: <20040701152134.7fd0fd1b.akpm@osdl.org>
In-Reply-To: <20040701231256.G8389@flint.arm.linux.org.uk>
References: <20040701175231.B8389@flint.arm.linux.org.uk>
	<20040701174731.GD15960@smtp.west.cox.net>
	<20040701190720.C8389@flint.arm.linux.org.uk>
	<1088711048.8875.5.camel@nosferatu.lan>
	<20040701205255.F8389@flint.arm.linux.org.uk>
	<20040701231256.G8389@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> Essentially, we run 'nm' against the object, and look for any line
> which matches the pattern '^ *U '.  With this, a failing output looks
> like:
> 
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> ldchk: .tmp_vmlinux1: final image has undefined symbols:
>   SIZEOF_MACHINE_DESC

What is the user supposed to do when this happens?
