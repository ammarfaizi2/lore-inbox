Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTILKmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 06:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTILKmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 06:42:53 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:49814 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261508AbTILKmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 06:42:53 -0400
Subject: Re: SII SATA request size limit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Penna Guerra <eu@marcelopenna.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309112357.41592.eu@marcelopenna.org>
References: <200309112357.41592.eu@marcelopenna.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063363288.5330.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 11:41:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 03:57, Marcelo Penna Guerra wrote:
> In recent kernels, the siimage driver limits the max kb per request size to 15 
> (7.5kb). As I was having no problems with rqsize of 128 (64kb), I decided to 
> comment out this part of the code and my system is rock solid.

It will depend what disks you have.

> kernels, so people can try to see if it's stable. I really don't beleive that 
> I have such an unique hardware configuration, so this should benefit other 
> people.

You can up it again at runtime.

