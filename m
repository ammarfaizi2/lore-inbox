Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTEMSdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTEMSdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:33:01 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:25559 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262424AbTEMSc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:32:59 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Date: Tue, 13 May 2003 20:46:22 +0200
User-Agent: KMail/1.5.1
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Drokin <green@namesys.com>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
References: <200305121455.58022.oliver@neukum.org> <200305131925.25121.oliver@neukum.org> <20030513172839.GG17033@suse.de>
In-Reply-To: <20030513172839.GG17033@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305132046.23122.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You don't have to reproduce, your case has two drives on a channel doing
> tcq. That's not really supported, and the last patch sent should make
> that scenario "work" (by not enabling tcq on any of them).

Is this a principal problem?

> The DTTA, according to FreeBSD, has a bug with > 64K transfers. But you
> said that worked fine, so...

It wasn't written to.

	Regards
		Oliver

