Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270755AbTHANB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 09:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270756AbTHANB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 09:01:56 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:8848 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270755AbTHANBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 09:01:55 -0400
Subject: Re: [PATCH 2.4.22-pre10] SAK: If a process is killed by SAK, give
	us an info about which one was killed
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, vda@port.imtp.ilyichevsk.odessa.ua
In-Reply-To: <200308011425.29058.m.c.p@wolk-project.de>
References: <200307312254.16964.m.c.p@wolk-project.de>
	 <1059739764.18399.0.camel@dhcp22.swansea.linux.org.uk>
	 <200308011425.29058.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059742660.18399.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Aug 2003 13:57:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-01 at 13:26, Marc-Christian Petersen wrote:
> On Friday 01 August 2003 14:09, Alan Cox wrote:
> 
> Hi Alan,
> 
> > This is potentially private information. It shouldnt be reported
> > I disagree with the patch
> well, it get logged to syslog(3) and dmesg(8). No normal user has access to 
> it, no?

It may also end up on the console

