Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWJMOeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWJMOeq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWJMOeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:34:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7395 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750855AbWJMOep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:34:45 -0400
Subject: Re: [PATCH] drivers/char/riscom8.c: save_flags()/cli()/sti()
	removal
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
       kernel Janitors <kernel-janitors@lists.osdl.org>
In-Reply-To: <1160739628.19143.376.camel@amol.verismonetworks.com>
References: <1160739628.19143.376.camel@amol.verismonetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Oct 2006 16:00:57 +0100
Message-Id: <1160751657.25218.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 17:10 +0530, ysgrifennodd Amol Lad:
> Removed save_flags()/cli()/sti() and used (light weight) spin locks
> 

Have you tested this and verified there are no recursive locking cases
in your changes ?

