Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTFYAP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 20:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTFYAP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 20:15:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28066 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263458AbTFYAP0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 20:15:26 -0400
Date: Tue, 24 Jun 2003 17:23:46 -0700 (PDT)
Message-Id: <20030624.172346.02273489.davem@redhat.com>
To: ink@jurassic.park.msu.ru
Cc: zolw@wombb.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.73 at alpha compile error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030624192024.A14606@jurassic.park.msu.ru>
References: <20030624160435.71b24c05.zolw@wombb.edu.pl>
	<20030624192024.A14606@jurassic.park.msu.ru>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
   Date: Tue, 24 Jun 2003 19:20:25 +0400

   On Tue, Jun 24, 2003 at 04:04:35PM +0200, Przemyslaw Stanis³aw Knycz wrote:
   > arch/alpha/kernel/built-in.o(.data+0x2260): undefined reference to
   > `sys_socket'
   
   Same problem with CONFIG_NET=n on sparc32/64, mips32/64, parisc and ia64.
   sys_socket should be a cond_syscall.
   
Applied, thanks Ivan.
