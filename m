Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTFJQp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTFJQp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:45:26 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:50137 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263459AbTFJQpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:45:22 -0400
Subject: Re: [PATCH] IDE Power Management, try 2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0306101832350.24343-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0306101832350.24343-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055264338.567.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jun 2003 18:58:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 18:36, Bartlomiej Zolnierkiewicz wrote:

> I've looked for users of ide_preempt in drivers/ide/ and I think
> that REQ_PREEMPT can later die if we fix drivers to correctly mark
> sense requests with REQ_SENSE...

Ok, I was not sure about REQ_SENSE exact meaning (I suppose the same
as REQ_PREEMPT for sense requests sent by the SCSI error handling ? :)

There's also a user in the TCQ stuff

Ben.

