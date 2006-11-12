Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755016AbWKLJPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbWKLJPT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 04:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755023AbWKLJPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 04:15:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6601 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755016AbWKLJPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 04:15:17 -0500
Subject: Re: OOM in 2.6.19-rc*
From: Arjan van de Ven <arjan@infradead.org>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
References: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 12 Nov 2006 10:15:14 +0100
Message-Id: <1163322915.3293.83.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-11 at 16:40 +0000, Christian Kujau wrote:
> Hello,
> 
> a few days ago I upgraded my desktop machine (x86_64) to ubuntu/edgy 
> thus completely changing the userland. Since I'm using kernel.org 
> kernels I upgraded to a current kernel as well (2.6.19-rc4-git from Nov 
> 4 and 2.6.19-rc4-mm2).

which modules/drivers do you use? Maybe there's a less commonly used on
in there that we could look at.
(The assumption is that all commonly used ones would have shown up
en-masse on lkml if there was a big leak in them; rarer ones less so)

