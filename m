Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWIYRnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWIYRnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWIYRnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:43:39 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:5310 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751388AbWIYRni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:43:38 -0400
Subject: Re: [PATCH] fix idiocy in asd_init_lseq_mdp()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Hammer, Jack" <Jack_Hammer@adaptec.com>, Al Viro <viro@ftp.linux.org.uk>
Cc: Luben Tuikov <ltuikov@yahoo.com>, dougg@torque.net,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060925173922.GL29920@ftp.linux.org.uk>
References: <4517EBF7.4020508@torque.net>
	 <20060925171634.69667.qmail@web31809.mail.mud.yahoo.com>
	 <20060925173922.GL29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 13:43:22 -0400
Message-Id: <1159206202.3463.62.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 18:39 +0100, Al Viro wrote:
> Far more interesting question: where does the hardware expect to see
> the
> upper 16 bits of that 32bit value?  Which one it is -
> LmSEQ_INTEN_SAVE(lseq)
> ori LmSEQ_INTEN_SAVE(lseq) + 2?

I don't honestly know.  The change was made as part of a slew of changes
by Robert Tarte at Adaptec to make the driver run on Big Endian
platforms.  I've copied Jack Hammer who's now looking after it in the
hope that he can enlighten us.

James


