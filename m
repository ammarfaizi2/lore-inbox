Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271834AbTHDP6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 11:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271835AbTHDP6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 11:58:41 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:31665 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S271834AbTHDP6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 11:58:40 -0400
Date: Mon, 4 Aug 2003 17:58:37 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Miles Lane <miles.lane@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 (linus' tree) -- drivers/net/3c59x.c:534: error:
 `WNOOXCVR_PWR' undeclared here (not in a function)
In-Reply-To: <200308040848.41908.miles.lane@comcast.net>
Message-ID: <Pine.LNX.4.51.0308041757110.22376@dns.toxicfilms.tv>
References: <200308040848.41908.miles.lane@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/net/3c59x.c:534: error: `WNOOXCVR_PWR' undeclared here (not in a
> function)
Funny, it should be: WNO_XCVF_PWR, edit 3c59x.c

But test2-bk3 is fine. Are you using any other patches ?

Regards,
Maciej

