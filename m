Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUGHVEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUGHVEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUGHVEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 17:04:08 -0400
Received: from [213.146.154.40] ([213.146.154.40]:33185 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264160AbUGHVEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 17:04:07 -0400
Date: Thu, 8 Jul 2004 22:04:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Erik Rigtorp <erik@rigtorp.com>, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040708210403.GA18049@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@suse.cz>, Erik Rigtorp <erik@rigtorp.com>,
	linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708204840.GB607@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps CONFIG_BOOTSPLASH should be in mainline after all?
> I really don't want to see 2 different incompatible sets
> of hooks into swsusp....

No.  This stuff has no business in the kernel, paint your fancy graphics
ontop of fbdev.  And the SuSE bootsplash patch is utter crap, I mean what
do you have to smoke to put a jpeg decoder into the kernel?
