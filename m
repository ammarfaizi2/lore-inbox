Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUA3Sks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUA3Sks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:40:48 -0500
Received: from [62.81.235.115] ([62.81.235.115]:32471 "EHLO
	smtp15.in.mad.eresmas.com") by vger.kernel.org with ESMTP
	id S262355AbUA3Skr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:40:47 -0500
Message-ID: <401AA52B.5050207@wanadoo.es>
Date: Fri, 30 Jan 2004 19:40:43 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.4.1) Gecko/20031114
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Compile Regression] 2.4.25-pre8: 126 warnings 0 errors
References: <401A9F2B.1060400@wanadoo.es>
In-Reply-To: <401A9F2B.1060400@wanadoo.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xose Vazquez Perez wrote:

>  kernel: 2.4.25-pre8
> 
>  distribution : RHL 9
>  gcc:    3.2.2
> 
> [...]

and as usual:
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.25-pre8; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.25-pre8/kernel/drivers/ide/ide-core.o
depmod:         init_cmd640_vlb
depmod: *** Unresolved symbols in /lib/modules/2.4.25-pre8/kernel/fs/binfmt_elf.o
depmod:         smp_num_siblings
depmod:         put_files_struct
depmod:         steal_locks

--
Software is like sex, it's better when it's bug free.

