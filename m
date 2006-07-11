Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWGKQD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWGKQD3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWGKQD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:03:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28062 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751097AbWGKQD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:03:27 -0400
Subject: Re: [2.6 patch] drivers/ide/: cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060711141637.GS13938@stusta.de>
References: <20060711141637.GS13938@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 17:19:04 +0100
Message-Id: <1152634744.18028.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 16:16 +0200, ysgrifennodd Adrian Bunk:
> This patch contains the following cleanups:

> - ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)

NAK. A simple grep shows ide_register_hw has users, 5 in fact as of
2.6.17.


