Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264730AbTFAU5E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 16:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbTFAU5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 16:57:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38883
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264730AbTFAU5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 16:57:03 -0400
Subject: Re: [PATCH] amd76x_pm port to 2.5.70
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason Lunz <lunz@falooley.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <slrnbdk6vt.m0b.lunz@orr.homenet>
References: <20030531183321.GA3408@varg.dyndns.org>
	 <slrnbdk6vt.m0b.lunz@orr.homenet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054498343.5862.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 21:12:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-01 at 16:27, Jason Lunz wrote:
> psavo@iki.fi said:
> > +++ linux-2.5.70-mod/drivers/char/amd76x_pm.c	2003-05-31 20:55:37.000000000 +0300
> 
> What is this thing doing in drivers/char? It has nothing whatsoever to
> do with char devices. Couldn't this be handled by the ACPI idle loop?

RTFS 8)

Its an alternative driver to the ACPI driver. I'm not sure where it
should go but in 2.4 its in drivers/char. 2.5.x puts the other PM
drivers in arch/i386 so maybe that is where it belongs

