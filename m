Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTJTAWw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 20:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTJTAWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 20:22:52 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:2716 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262344AbTJTAWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 20:22:51 -0400
Date: Mon, 20 Oct 2003 02:22:46 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: =?iso-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ben Collins <bcollins@debian.org>
Subject: bkcvs and bksvn out of sync (Was: Re: [2.6.0-test7-bk] undefined reference to `NEW_TO_OLD_GID')
Message-ID: <20031020002246.GA14808@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <1065702589.2234.3.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1065702589.2234.3.camel@debian>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Ramón is probably using the bksvn gateway, after investication, it
 seams that this changeset was not completely commited to bksvn:

	ChangeSet@1.1296.61.2  03-10-06 15:15:36-07:00  ak@de[torvalds]

 Althogh it is OK in bkcvs.

On Thu, Oct 09, 2003 at 02:29:50PM +0200, Ramón Rey Vicente wrote:
> The warnings:
> 
>   CC      fs/binfmt_elf.o
> fs/binfmt_elf.c: En la función `fill_psinfo':
> fs/binfmt_elf.c:1123: aviso: implicit declaration of function
> `NEW_TO_OLD_UID'
> fs/binfmt_elf.c:1124: aviso: implicit declaration of function
> `NEW_TO_OLD_GID'
> 
>  CC      ipc/util.o
> ipc/util.c: En la función `ipc64_perm_to_ipc_perm':
> ipc/util.c:424: aviso: implicit declaration of function `NEW_TO_OLD_UID'
> ipc/util.c:425: aviso: implicit declaration of function `NEW_TO_OLD_GID'


-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
