Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbSJRDWv>; Thu, 17 Oct 2002 23:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbSJRDWv>; Thu, 17 Oct 2002 23:22:51 -0400
Received: from dsl-65-188-232-225.telocity.com ([65.188.232.225]:48597 "EHLO
	area51.underboost.net") by vger.kernel.org with ESMTP
	id <S262862AbSJRDWu>; Thu, 17 Oct 2002 23:22:50 -0400
Date: Wed, 16 Oct 2002 23:25:52 -0400 (AST)
From: dijital1 <dijital1@underboost.net>
To: linux-kernel@vger.kernel.org
Subject: referencing other modules
Message-ID: <Pine.LNX.4.44.0210162322070.12334-100000@area51.underboost.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have any ideas as to why this following 3 lines of code
don't work? The kernel version is 2.5.43 and I have several other modules
loaded before I load the module containing this code. From what I can
discern in linux/kernel/module.c new modules are added to the head of the
list to it seems that my code would work. Any help or suggestions would be
appreciated. Incidentally, this code is being called from the module
initialisation function.

    struct module *next_mod;
    next_mod=THIS_MODULE->next;
    printk(KERN_DEBUG"%s\n", next_mod->name);


Ron Henry

"the illiterate of the future are not those who can neither read
or write; but those who cannot learn, unlearn, and relearn..."

