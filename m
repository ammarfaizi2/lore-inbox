Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWGKOeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWGKOeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWGKOeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:34:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60872 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750870AbWGKOeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:34:11 -0400
Subject: Re: [2.6 patch] drivers/ide/: cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44B3B61B.4010206@tls.msk.ru>
References: <20060711141637.GS13938@stusta.de> <44B3B61B.4010206@tls.msk.ru>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 16:33:24 +0200
Message-Id: <1152628404.3128.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 18:30 +0400, Michael Tokarev wrote:
> Adrian Bunk wrote:
> > This patch contains the following clenups:
> > - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
> 
> Hmm.  So, ide drivers will be unloadable forever, without
> a chance to fix it someday? ;)

that's why it's #if 0... so that if someone goes in to fix it he only
has to remove the if 0 line...


