Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTDHXBY (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbTDHXBY (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:01:24 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:61406 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S262513AbTDHXBX (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 19:01:23 -0400
Date: Tue, 08 Apr 2003 17:12:39 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges
Message-ID: <3688420000.1049843559@aslan.btc.adaptec.com>
In-Reply-To: <1049843229.2107.46.camel@mulgrave>
References: <1049843229.2107.46.camel@mulgrave>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I take it 2.5 is up to date, right?  Because otherwise we should have
> seen an update notice go across linux-scsi@vger.kernel.org.

In the past, I have sent mail directly to Linus which has worked for 2.5.
Unfortunately, it looks like he has not applied the last bundle I posted
to him on 2003/03/25.  This is the same bk output as posted on my website.

> This problem looks to be present in 2.5, so should I apply the patch?

It would be better to just upgrade the driver with bits I submitted to
Linus.  I have another update coming to correctly fix the del_timer_sync()
issue since the last, unsanctioned, change in this area has a large potential
to cause a deadlock.

--
Justin

