Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263080AbVEGMYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbVEGMYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 08:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbVEGMYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 08:24:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61605 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263076AbVEGMYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 08:24:21 -0400
Subject: Re: [2.6 patch] drivers/net/ixgb/: possible cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, ayyappan.veeraiyan@intel.com,
       ganesh.venkatesan@intel.com, john.ronciak@intel.com, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <5fc59ff3050506153523cd12dd@mail.gmail.com>
References: <20050506211834.GM3590@stusta.de>
	 <5fc59ff3050506153523cd12dd@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 07 May 2005 14:24:04 +0200
Message-Id: <1115468645.6388.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 15:35 -0700, Ganesh Venkatesan wrote:
> Adrian:
> 
> Some of your suggestions are already part of the driver we are
> currently testing. This was based partly on your Feb '05 patch. We
> will not be able to apply your patch as is since some of the changes
> are in part of code that is shared with other drivers that are not
> GPLd.

this sounds really bad.

Can you talk to the intel people in the ACPI group, they had a similar
issue before but were able to resolve it by a proper dual license
comment. It would be much preferable if people CAN do changes to the
entire driver... what's the point of having it open source otherwise ;)


