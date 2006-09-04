Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWIDQDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWIDQDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 12:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWIDQDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 12:03:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12006 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964907AbWIDQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 12:03:41 -0400
Subject: Re: [PATCH] audit/accounting: tty locking
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1157384179.30801.100.camel@localhost.localdomain>
References: <1157380592.30801.94.camel@localhost.localdomain>
	 <1157384179.30801.100.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 04 Sep 2006 18:03:19 +0200
Message-Id: <1157385800.5819.98.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 16:36 +0100, Alan Cox wrote:
> Ar Llu, 2006-09-04 am 15:36 +0100, ysgrifennodd Alan Cox:
> > Fairly basic stuff .. make sure the name we are encoding doesn't vanish
> > under us.
> 
> Here's a replacement that is more paranoid about the locking as
> suggested by Arjan. The whole current->signal-> locking is all deeply
> strange but its for someone else to sort out. Add rather than replace
> the lock for acct.c
> 
> Signed-off-by: Alan Cox <alan@redhat.com>


Acked-by: Arjan van de Ven <arjan@linux.intel.com>


