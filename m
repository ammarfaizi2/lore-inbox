Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUHaJE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUHaJE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUHaJE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:04:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:30601 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267549AbUHaJD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:03:59 -0400
Date: Tue, 31 Aug 2004 02:02:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helge.hafting@hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm2 Inconsistent kallsyms
Message-Id: <20040831020206.191c0d01.akpm@osdl.org>
In-Reply-To: <41343C0F.5020508@hist.no>
References: <20040830235426.441f5b51.akpm@osdl.org>
	<41343C0F.5020508@hist.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@hist.no> wrote:
>
> This compiled, but failed anyway (after make mrproper):
> 
>    LD      vmlinux
>    SYSMAP  System.map
>    SYSMAP  .tmp_System.map
>  Inconsistent kallsyms data, try setting CONFIG_KALLSYMS_EXTRA_PASS

It can happen I guess, depending on which way the wind was blowing when
your binutils was released.

Do you try doing what it said?
