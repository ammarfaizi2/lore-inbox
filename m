Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422670AbWHUPLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422670AbWHUPLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 11:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWHUPLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 11:11:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45705 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422670AbWHUPLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 11:11:11 -0400
Subject: Re: [Patch] Fix signedness error in drivers/media/video/vivi.c
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1156098327.4051.36.camel@localhost.localdomain>
References: <1156004367.17863.2.camel@alice>
	 <1156098327.4051.36.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 21 Aug 2006 12:10:51 -0300
Message-Id: <1156173051.3580.36.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-08-20 às 19:25 +0100, Alan Cox escreveu:
> Ar Sad, 2006-08-19 am 18:19 +0200, ysgrifennodd Eric Sesterhenn:
> > Since videobuf_reqbufs() returns negative values on errors the current
> > code does no real error checking since gcc removes the comparison.
> > This patch fixes this issue by making ret a normal, signed integer.
> > 
> > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> > 
> 
> Doesn't apply to latest driver tree but the problem is still present.
Hmm... patch applied fine to v4l-dvb hg tree. 
> 
> Alan
> 
Cheers, 
Mauro.

