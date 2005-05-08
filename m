Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262922AbVEHScC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbVEHScC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 14:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVEHScB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 14:32:01 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:4179 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262922AbVEHSbv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 14:31:51 -0400
Date: Sun, 8 May 2005 20:32:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: li nux <lnxluv@yahoo.com>
Cc: "Espen  \"Fjellv?r\" Olsen" <espenfjo@gmail.com>,
       linux <linux-kernel@vger.kernel.org>
Subject: Re: compiling "hello world" kernel module on 2.6 kernel
Message-ID: <20050508183244.GC8182@mars.ravnborg.org>
References: <20050507142027.61160.qmail@web60522.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507142027.61160.qmail@web60522.mail.yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 07:20:26AM -0700, li nux wrote:
> Thanks Espen, but it didnt worked.
> Please tell me where i am wrong:
> hello.c is at /local/usr/linux-2.6.5-7.162
> i did a cd to /local/usr/linux-2.6.5-7.162
> created makefile called Makefile.1 as u suggested.
> and did a make -f Makefile.1

Wrong.
Put hello.c somewhere in you home directory.
The Makefile shall be placed in same directory.

Restore any files you have overwritten in the kernel dir (like the
Makefile)
Then it will work out.

If not post full details including the output of the make command with
V=1 included: $(MAKE) -C $(KERNELDIR) V=1 M=$(PWD)

	Sam
