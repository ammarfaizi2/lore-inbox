Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVEOUsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVEOUsu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 16:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVEOUst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 16:48:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:412 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261239AbVEOUsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 16:48:46 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Dave Jones <davej@redhat.com>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <1116189693.17990.1.camel@localhost.localdomain>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
	 <1116027488.6380.55.camel@mindpipe>
	 <1116084186.20545.47.camel@localhost.localdomain>
	 <1116088229.8880.7.camel@mindpipe>
	 <1116089068.6007.13.camel@laptopd505.fenrus.org>
	 <1116093396.9141.11.camel@mindpipe>
	 <1116093694.6007.15.camel@laptopd505.fenrus.org>
	 <1116098504.9141.31.camel@mindpipe>
	 <1116100126.6007.17.camel@laptopd505.fenrus.org>
	 <1116114052.9141.38.camel@mindpipe>
	 <1116142233.6270.9.camel@laptopd505.fenrus.org>
	 <1116189693.17990.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 15 May 2005 22:48:27 +0200
Message-Id: <1116190107.6270.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.1 (+)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (1.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-15 at 21:41 +0100, Alan Cox wrote:
> On Sul, 2005-05-15 at 08:30, Arjan van de Ven wrote:
> > stop entirely.... (and that is also happening more and more and linux is
> > getting more agressive idle support (eg no timer tick and such patches)
> > which will trigger bios thresholds for this even more too.
> 
> Cyrix did TSC stop on halt a long long time ago, back when it was worth
> the power difference.

With linux going to ACPI C2 mode more... tsc is defined to halt in C2...


