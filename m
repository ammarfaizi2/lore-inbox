Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266016AbUEUUfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbUEUUfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUEUUfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:35:23 -0400
Received: from outmx015.isp.belgacom.be ([195.238.2.87]:15789 "EHLO
	outmx015.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S266016AbUEUUfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:35:16 -0400
Subject: Re: [PATCH 2.6.6-mm4] ring_info spinlock initialization
From: FabF <Fabian.Frederick@skynet.be>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405211611580.2864@montezuma.fsmlabs.com>
References: <1085167134.7954.3.camel@bluerhyme.real3>
	 <Pine.LNX.4.58.0405211611580.2864@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1085171883.7948.6.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 May 2004 22:38:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-21 at 22:12, Zwane Mwaikambo wrote:
> On Fri, 21 May 2004, FabF wrote:
> 
> > Hi,
> > 	ring_info spinlock was not initialized in INIT_KIOCTX.
> 
> Shouldn't something have caught that?
aio stuff is the only place which doesn't use INIT_KIOCTX and does 
explicitely that initialization so I guess this patch is needed ...

> 
> 	Zwane
> 
> 

