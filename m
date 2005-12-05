Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVLEVTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVLEVTp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVLEVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:19:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24522 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932514AbVLEVTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:19:44 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512051826.06703.andrew@walrond.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <200512051826.06703.andrew@walrond.org>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 21:19:35 +0000
Message-Id: <1133817575.11280.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 18:26 +0000, Andrew Walrond wrote:
> > On December 6th, 2005 the kernel developers en mass decide that binary
> > modules are legally fine and also essential for the progress of linux,
> 
> Has anyone (influential) actually being toying with this idea? I hope not, but 
> if they are, I'd like to know who to lobby...

http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=e3c3374fbf7efe9487edc53cd10436ed641983aa

Remember that the only distinction between EXPORT_SYMBOL() and
EXPORT_SYMBOL_GPL() is that the latter is a technological measure to
prevent abuse. The use of EXPORT_SYMBOL_GPL() cannot actually impose any
additional restrictions over and above what the GPL requires of
EXPORT_SYMBOL() -- because any additional restrictions would themselves
violate the GPL.

Thus, the only point in the above-linked patch is to remove a technical
measure which prevents abuse. I feel very strongly that it should be
reverted.

-- 
dwmw2

