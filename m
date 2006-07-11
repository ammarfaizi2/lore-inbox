Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWGKOa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWGKOa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWGKOa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:30:56 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:30545 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750829AbWGKOaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:30:55 -0400
Message-ID: <44B3B61B.4010206@tls.msk.ru>
Date: Tue, 11 Jul 2006 18:30:51 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ide/: cleanups
References: <20060711141637.GS13938@stusta.de>
In-Reply-To: <20060711141637.GS13938@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following clenups:
> - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()

Hmm.  So, ide drivers will be unloadable forever, without
a chance to fix it someday? ;)

Thanks.

/mjt
