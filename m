Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTISOkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 10:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbTISOkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 10:40:43 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:17586 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261598AbTISOkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 10:40:42 -0400
Subject: Re: [PATCH] 2.6.0-testX: zoran driver documentation fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: trivial@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1063981711.2220.113.camel@shrek.bitfreak.net>
References: <1063981711.2220.113.camel@shrek.bitfreak.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063982339.18723.16.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Fri, 19 Sep 2003 15:39:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-19 at 15:28, Ronald Bultje wrote:
> Hi,
> 
> the zoran kernel driver is called 'zoran.o' in its CVS (historical
> thing, I don't know why), and it's called zr36067.o in the kernel tree.
> The documentation in the kernel tree refers to zoran.o, though, which is
> (in the kernel tree) the driver for zr36120-based cards, rather than the
> driver for zr360x7-based cards.

This is a good change. Historically both the 36067 and 36120 drivers and
a couple of other oddments were all called "zoran". When it got merged
it seemed wise to use chip names
