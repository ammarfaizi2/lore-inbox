Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264690AbTFEOOe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 10:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264691AbTFEOOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 10:14:34 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:34014 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264690AbTFEOOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 10:14:33 -0400
Subject: Re: [PATCH] IDE Power Management, try 2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0306051604320.18218-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0306051604320.18218-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054823279.765.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 16:27:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I had to add yet another rq->flags bit for that, and I think that sucks
> 
> You don't have if you use additional, default pm_state (on == 0).
> This sucks too, but a bit less.

Can you elaborate ? I'm not sure I understand what you meant

> I think extending struct request is the way to go,
> pm_step & pm_state or even pointer to rq_pm_struct.

Ok. I'll wait for Jens ack and go that way if he agrees.

Ben.

