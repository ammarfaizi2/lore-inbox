Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTEZWtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTEZWtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:49:04 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:41363 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S262356AbTEZWtC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:49:02 -0400
Date: Tue, 27 May 2003 00:38:03 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: xfs don't compil in linux-2.5 BK
Message-ID: <20030526223803.GB14954@magma.unil.ch>
References: <20030526193136.GB10276@magma.unil.ch> <1053986469.3754.6.camel@nalesnik.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1053986469.3754.6.camel@nalesnik.localhost>
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 11:01:12PM +0100, Grzegorz Jaskiewicz wrote:

> looks like LINUX_VERSION_CODE is not defined
> try this (as 2.5.69 > than 2.5.9)

Well, maybe BK is not for me:

greg@greg:linux >make dep && make bzImage && make modules && sudo make modules_install
*** Warning: make dep is unnecessary now.
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
  CHK     include/linux/compile.h
dnsdomainname: Unknown host
  CC      fs/xfs/pagebuf/page_buf.o
In file included from fs/xfs/pagebuf/page_buf.c:65:
fs/xfs/pagebuf/page_buf_internal.h:46:24: operator '<' has no left operand
fs/xfs/pagebuf/page_buf_internal.h:51:24: operator '<' has no left operand
make[2]: *** [fs/xfs/pagebuf/page_buf.o] Error 1
make[1]: *** [fs/xfs] Error 2
make: *** [fs] Error 2
Exit 2

Thank you very much,

	Grégoire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
