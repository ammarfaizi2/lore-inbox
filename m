Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTLLRfb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 12:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTLLRfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 12:35:31 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:65509 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261326AbTLLRf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 12:35:26 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Daniel Tram Lux <daniel@starbattle.com>
Subject: Re: [patch] ide.c as a module
Date: Fri, 12 Dec 2003 18:37:31 +0100
User-Agent: KMail/1.5.4
References: <20031211202536.GA10529@starbattle.com> <200312121646.04047.bzolnier@elka.pw.edu.pl> <20031212171711.GA15954@starbattle.com>
In-Reply-To: <20031212171711.GA15954@starbattle.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312121837.31121.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 of December 2003 18:17, Daniel Tram Lux wrote:
> Hi Bartlomiej,
>
> I applied your changes only, reverting all of mine...
>
> moving the initializing=1 also solves the multiple init problem...thanks
>
> here is how the patch looks like now:

Thanks.  I noticed that in 2.4 ide_probe_module() has revaldiate parameter
(I am currently fixing modules in 2.6 so I over-looked it before), so I need
to check if these changes are sufficient.  If so I will submit to Marcelo.

Regards,
--bart

