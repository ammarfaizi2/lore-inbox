Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVLEVyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVLEVyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVLEVyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:54:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46998 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964819AbVLEVys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:54:48 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133817888.9356.78.camel@laptopd505.fenrus.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <200512051826.06703.andrew@walrond.org>
	 <1133817575.11280.18.camel@localhost.localdomain>
	 <1133817888.9356.78.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 21:54:44 +0000
Message-Id: <1133819684.11280.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 22:24 +0100, Arjan van de Ven wrote:
> I think you're wrong on this. Not about thinking it should be reverted
> per se, but in the big picture it's not linked to the scenario. One
> export more or less doesn't matter at all. 

Yeah, I suppose that's true to a large extent, but the fact that Linus
is actively aiding and abetting a licence violator by reverting this
particular symbol from EXPORT_SYMBOL_GPL() to EXPORT_SYMBOL() sends a
very strong message. And it's not one which we should be sending.

Linus chose not to collect copyright assignments; therefore this kind of
decision isn't his to make. We are bound by the GPL and (GPLv3 aside) we
have no practical option to change that -- by royal decree or otherwise.

I think it's time to recognise that there's no difference in licensing
terms between EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(). The _only_
difference is that the latter will lead to harsher punishments for
violators because it needs to be actively circumvented. 

We should switch _everything_ to EXPORT_SYMBOL_GPL(). It can't change
the licensing question at all -- if binary-only modules were legal
before they will _still_ be legal, because we're not allowed to impose
additional restrictions anyway. But the change does strengthen the case
against anyone found to be in violation of the licence, because they
have to deliberately circumvent the protection it implies.

-- 
dwmw2

