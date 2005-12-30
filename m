Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVL3JmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVL3JmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 04:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVL3JmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 04:42:19 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:65383 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S1751237AbVL3JmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 04:42:18 -0500
X-ME-UUID: 20051230094217109.029D71C000B2@mwinf1212.wanadoo.fr
Subject: Re: git fetching
From: Xavier Bestel <xavier.bestel@free.fr>
To: Ryan Anderson <ryan@michonline.com>
Cc: Alejandro Bonilla <alejandro.bonilla@hp.com>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43B48A8C.8000708@michonline.com>
References: <43B48516.2030701@hp.com> <20051230010151.GC12822@redhat.com>
	 <43B48A8C.8000708@michonline.com>
Content-Type: text/plain
Message-Id: <1135935728.31203.80.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 30 Dec 2005 10:42:08 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 02:17, Ryan Anderson wrote:

> Also, out of curiosity, do:
> 	du -sh .git/objects/ .git/objects/pack/
> 
> You shouldn't see a .git/objects/pack/ much greater than 200 meg, in
> fact, on freshly cloned tree it would only be about 100 meg:
> 
> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/pack/

[xav@bip:~/git/linux-2.6]$ du -sh .git/objects/ .git/objects/pack/
1019M   .git/objects/
645M    .git/objects/pack/

It's not freshly cloned, but it's freshly updated and contains nothing
but the upstream sources.

	Xav


