Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbTGIGEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 02:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265714AbTGIGEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 02:04:14 -0400
Received: from f22.mail.ru ([194.67.57.55]:49165 "EHLO f22.mail.ru")
	by vger.kernel.org with ESMTP id S265713AbTGIGEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 02:04:14 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: printk in atomic context
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 09 Jul 2003 10:18:34 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19a8Hi-0004GN-00.arvidjaar-mail-ru@f22.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it possible (safe) to use printk in atomic context, i.e. under
spinlock or inside of preemption-disabled region?

The same question about 2.4 (here I guess only spinlock?)

TIA

-andrey
