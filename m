Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVDWOf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVDWOf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 10:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVDWOf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 10:35:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32733 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261596AbVDWOfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 10:35:54 -0400
Subject: Re: Git-commits mailing list feed.
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: torvalds@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <426A5BFC.1020507@ppp0.net>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
	 <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>
	 <426A4669.7080500@ppp0.net>
	 <1114266083.3419.40.camel@localhost.localdomain>
	 <426A5BFC.1020507@ppp0.net>
Content-Type: text/plain
Date: Sun, 24 Apr 2005 00:35:07 +1000
Message-Id: <1114266907.3419.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-23 at 16:30 +0200, Jan Dittmer wrote:
> > LASTRELEASE=`ls -rt .git/tags | grep -v git | grep -v MailDone | tail -1`
> 
> My .git/tags is empty. At least 2.6.12-rc3 is not tagged so I wasn't sure
> how to extract the latest release from the git tree.
> ketchup was the most comfortable way.

Nah, asking Linus to tag his releases is the most comfortable way.

mkdir .git/tags
echo 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 > .git/tags/2.6.12-rc2
echo a2755a80f40e5794ddc20e00f781af9d6320fafb > .git/tags/2.6.12-rc3

-- 
dwmw2

