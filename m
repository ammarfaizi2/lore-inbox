Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTDHXQu (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTDHXQu (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:16:50 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:52229 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262569AbTDHXQs (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 19:16:48 -0400
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3688420000.1049843559@aslan.btc.adaptec.com>
References: <1049843229.2107.46.camel@mulgrave> 
	<3688420000.1049843559@aslan.btc.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Apr 2003 18:28:12 -0500
Message-Id: <1049844494.1788.61.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-08 at 18:12, Justin T. Gibbs wrote:
> > I take it 2.5 is up to date, right?  Because otherwise we should have
> > seen an update notice go across linux-scsi@vger.kernel.org.
> 
> In the past, I have sent mail directly to Linus which has worked for 2.5.
> Unfortunately, it looks like he has not applied the last bundle I posted
> to him on 2003/03/25.  This is the same bk output as posted on my website.

Well, the aic7xxx is part of SCSI, and SCSI has an active BK tree for
accumulating patches and pushing them to Linus.  If you want to
circumvent this, then patches will get lost sometimes.

The way to avoid this is to send patches to linux-scsi@vger.kernel.org.

> > This problem looks to be present in 2.5, so should I apply the patch?
> 
> It would be better to just upgrade the driver with bits I submitted to
> Linus.  I have another update coming to correctly fix the del_timer_sync()
> issue since the last, unsanctioned, change in this area has a large potential
> to cause a deadlock.

I'll see if I can pull them.

James


