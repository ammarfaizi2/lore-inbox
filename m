Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269679AbUJGER7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269679AbUJGER7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269683AbUJGER7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:17:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:56015 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269679AbUJGER5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:17:57 -0400
Date: Wed, 6 Oct 2004 21:16:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matt_Domsch@dell.com, linux-kernel@vger.kernel.org, alan@redhat.com,
       david.balazic@hermes.si
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add
 CONFIG_EDD_SKIP_MBR
Message-Id: <20041006211605.17c1cb41.akpm@osdl.org>
In-Reply-To: <4164BF82.2040608@pobox.com>
References: <20041004214803.GC2989@lists.us.dell.com>
	<4164BF82.2040608@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > This also adds CONFIG_EDD_SKIP_MBR to eliminate reading the MBR on
>  > each BIOS-presented disk, in case there are further problems in this
>  > area.
> 
> 
>  Build fails on x86-64:
> 
>  [...]
>     SYSMAP  System.map
>     SYSMAP  .tmp_System.map
>     AS      arch/x86_64/boot/setup.o
>  In file included from arch/x86_64/boot/setup.S:536:
>  arch/i386/boot/edd.S:17: macro names must be identifiers
>  make[1]: *** [arch/x86_64/boot/setup.o] Error 1
>  make: *** [bzImage] Error 2

hm, works OK here.

Is it missing config.h?
