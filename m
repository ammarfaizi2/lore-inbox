Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVGNHiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVGNHiI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 03:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVGNHiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 03:38:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40632 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262940AbVGNHhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 03:37:42 -0400
Subject: Re: moving DRM header files
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Airlie <airlied@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e99705071321044c216db4@mail.gmail.com>
References: <21d7e99705071321044c216db4@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 09:37:38 +0200
Message-Id: <1121326658.3967.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 14:04 +1000, Dave Airlie wrote:
> Hi,
> I'd like to move the interface DRM header files (drm.h and *_drm.h)
> somewhere more useful and also more "user-space" visible, (i.e. so
> kernel-headers could start picking them up.)

I would suggest making ONE userspace visible header, and just put that
as include/linux/drm.h
and separate into that *ONLY* the userspace visible parts, and *NONE* of
the kernel visible parts, and keep the kernel parts in drivers/char/drm.


