Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTELWUf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbTELWUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:20:34 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27288 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262813AbTELWUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:20:33 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com>
	<20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 13 May 2003 00:36:48 +0200
In-Reply-To: <20030512194245.GG17033@suse.de>
Message-ID: <m33cjjzta7.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> I don't think the multiple pending _and_ active is that big a deal, and
> besides _everybody_ uses write back caching on IDE which makes TCQ for
> writes very uninteresting.

Isn't it recommended to turn off write back caching when doing
software raid?  It will be hard to guarantee the consistency of the
raid set otherwise.  So I think that TCQ can be very interesting for
some loads.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
