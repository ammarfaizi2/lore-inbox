Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTFJGyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 02:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTFJGyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 02:54:44 -0400
Received: from AMarseille-201-1-2-177.w193-253.abo.wanadoo.fr ([193.253.217.177]:23591
	"EHLO gaston") by vger.kernel.org with ESMTP id S262390AbTFJGyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 02:54:44 -0400
Subject: Re: [PATCH] IDE Power Management, try 3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200306062325.23317.bzolnier@elka.pw.edu.pl>
References: <200306062325.23317.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055228889.641.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jun 2003 09:08:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-06 at 23:25, Bartlomiej Zolnierkiewicz wrote:
> I have corrected it a bit and I am going to submit it, any comments?
> 
> Ben, can you verify my changes and check that it still works after 'fixing'?
> :-)

Heh, thanks for the "corrections" ;)

Regarding ide_wait_not_busy(), I'd rather have it return -ENODEV
when it reads 0xff, what do you think ?

I'll test the patch later today (just back from a long week-end),
Ben.


