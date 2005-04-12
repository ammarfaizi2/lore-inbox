Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVDLPSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVDLPSY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVDLPPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:15:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59830 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262462AbVDLPNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:13:34 -0400
Date: Tue, 12 Apr 2005 16:13:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
       linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412151332.GA10752@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Kilau, Scott" <Scott_Kilau@digi.com>,
	Ihalainen Nickolay <ihanic@dev.ehouse.ru>, admin@list.net.ru,
	linux-kernel@vger.kernel.org, Wen Xiong <wendyx@us.ibm.com>
References: <335DD0B75189FB428E5C32680089FB9F038FBB@mtk-sms-mail01.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F038FBB@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 09:55:10AM -0500, Kilau, Scott wrote:
> We (Digi) cares.
> 
> We want people to use our DGNC driver over the JSM driver in all
> cases except the 2 port model of the board.

And we (kernel developers) don't care what drivers digi wants people
to use.  We empower people to use free software with whatever hardware
can be supported.  Our drivers are often not from vendors at all, and
even when vendor drivers exist we often support better (in our opinion)
drivers

> 
> This is because the DGNC driver contains extra features that the JSM
> driver
> Has stripped out, to get into the kernel sources,
> and our other customers WANT these features!

There are people who just want the card supported.  There's no reason
to deny the driver to them.

> We cannot have a situation where the JSM driver takes control of the PCI
> card
> before the DGNC driver can take it first!

Sure, we can have the situation easily.  If you want us to care for your
other driver make sure it's submitted for kernel inclusion.

> Please, do *NOT* add this patch!!!
> 
> Do I, as a copyright holder on the code in question, have any rights at
> all,
> or are you just going to trample over my wishes, in your zeal?

You do have lots of rights.  But as you put the code under the GPL we
do have rights aswell now, and one of the most important rights you gave
us is to modify and redistribute the code under the terms of the GPL.

