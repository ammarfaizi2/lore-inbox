Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbSKOCkb>; Thu, 14 Nov 2002 21:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbSKOCka>; Thu, 14 Nov 2002 21:40:30 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:39339 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S265608AbSKOCka>; Thu, 14 Nov 2002 21:40:30 -0500
From: SL Baur <steve@kbuxd.necst.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15828.24830.494099.469378@sofia.bsd2.kbnes.nec.co.jp>
Date: Fri, 15 Nov 2002 11:50:38 +0900
To: Skip Ford <skip.ford@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module-init-tools breaks kallsyms
X-Mailer: VM 7.03 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford writes on lkml:

> Install of module-init-tools moves the old tools to *.old but it
> doesn't address kallsyms. In the case of kallsyms being a link to
> insmod, it breaks. Since the new insmod is supposed to call
> insmod.old when appropriate, I'm not sure why it breaks. But it
> doesn't work here.

> To successfully compile a kernel < 2.5.47-bk2 after
> module-init-tools installation, with kallsyms being a symlink, you
> need to link it to insmod.old instead.

I've made a merged rpm of modutils and module-init-tools that deals
with this and sent it to Rusty.

