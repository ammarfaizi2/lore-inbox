Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVDMH2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVDMH2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 03:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVDMH2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 03:28:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64972 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262492AbVDMH2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 03:28:00 -0400
Date: Wed, 13 Apr 2005 08:27:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Cc: Kilau@arcor-online.net, Scott <Scott_Kilau@digi.com>,
       Greg KH <greg@kroah.com>, Ihalainen Nickolay <ihanic@dev.ehouse.ru>,
       admin@list.net.ru, linux-kernel@vger.kernel.org,
       Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050413072746.GB32634@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" <7eggert@gmx.de>,
	Kilau@arcor-online.net, Scott <Scott_Kilau@digi.com>,
	Greg KH <greg@kroah.com>, Ihalainen Nickolay <ihanic@dev.ehouse.ru>,
	admin@list.net.ru, linux-kernel@vger.kernel.org,
	Wen Xiong <wendyx@us.ibm.com>
References: <3SAEx-7Yo-9@gated-at.bofh.it> <E1DLUhQ-0001ad-Kd@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DLUhQ-0001ad-Kd@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you should supply a patch that makes the in-kernel driver print a
> short notice about your other driver. E.g.
> ----
> The foo driver is a stripped-down version of the bar driver. To get the
> additional configuration and diagnosis infrastructure, see the
> instructions on url.
> ----

No.  The jsm driver is one that's many bugs in the digi driver fixes and
broken interfaces stripped out.  We don't want users to fall in the trap
and use the inferior digi driver.
