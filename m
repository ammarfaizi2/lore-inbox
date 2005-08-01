Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVHAQd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVHAQd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVHAQX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:23:56 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:33732
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262226AbVHAQVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:21:44 -0400
Subject: Re: reed-solomon lib
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Simon Sudler <Simon.Sudler@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42EE4462.9030101@gmx.net>
References: <42EE4462.9030101@gmx.net>
Content-Type: text/plain
Organization: Linutronix
Date: Mon, 01 Aug 2005 18:22:21 +0200
Message-Id: <1122913341.13828.3.camel@lap02.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 17:48 +0200, Simon Sudler wrote:
>          if (nroots < 0 || nroots >= (1<<symsize) || nroots > 8)
>                  return NULL;
....
> After removing of the "nroots > 8" my code was working fine...
> perhaps someone was to carful to avoid a errors with the kmalloc
> function in rs_init.

Honestly, I don't remember why it is there. Definitely not due to the
kmalloc. It can be safely removed. I'll fix this. 

tglx


