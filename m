Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbVJEPCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbVJEPCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 11:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbVJEPCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 11:02:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27553 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965201AbVJEPCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 11:02:34 -0400
Subject: Re: what is the difference between __free_page() &
	page_cache_release()
From: Arjan van de Ven <arjan@infradead.org>
To: yogeshwar sonawane <yogyas@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b681c62b0510050757n2b3369flfba2d125912d8655@mail.gmail.com>
References: <b681c62b0510050757n2b3369flfba2d125912d8655@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 17:02:28 +0200
Message-Id: <1128524548.2920.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
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

On Wed, 2005-10-05 at 20:27 +0530, yogeshwar sonawane wrote:
> hi,
> I am writing a driver for 2.6 in which i am locking down some pages
> into the physical memory by manually traversing the page tables. After
> my work with those pages is finished, i free them using 
> __free_page(). For some cases it is running fine. But while running
> some applications, i got the following error:

you forgot to put in a url to your code

