Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbTIBROh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbTIBROh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:14:37 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:31267 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261632AbTIBROg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:14:36 -0400
Date: Tue, 2 Sep 2003 13:14:22 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ymf724 oops in 2.4.22, boot fails
Message-ID: <20030902131422.B14511@devserv.devel.redhat.com>
References: <200309021707.h82H7I628954@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309021707.h82H7I628954@devserv.devel.redhat.com>; from vanl@megsinet.net on Fri, Aug 29, 2003 at 03:45:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a. if the read of AC97_EXTENDED_ID fails just leave eid NULL and continue
>    to fix??? no codec attached.  Here is my dmesg output for this device:

Alan, don't forget to double-check cs46xx. All the code
in ymfpci which handles ac97 is taken from there.

I don't think 2.4 at this stage is a good place for
bulk renamings like codec=>unit.

-- Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
> a. if the read of AC97_EXTENDED_ID fails just leave eid NULL and continue
>    to fix??? no codec attached.  Here is my dmesg output for this device:

Alan, don't forget to double-check cs46xx. All the code
in ymfpci which handles ac97 is taken from there.

I don't think 2.4 at this stage is a good place for
bulk renamings like codec=>unit.

-- Pete
