Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWAZGxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWAZGxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 01:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWAZGxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 01:53:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30678 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751202AbWAZGxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 01:53:37 -0500
Subject: Re: [PATCH] media video stradis memory fix
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jiri Slaby <xslaby@fi.muni.cz>
Cc: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       laredo@gnu.org, Dave Jones <davej@redhat.com>
In-Reply-To: <20060124112541.99C4822B406@anxur.fi.muni.cz>
References: <20060124060103.GA3532@redhat.com>
	 , <20060124060103.GA3532@redhat.com>
	 <20060124112541.99C4822B406@anxur.fi.muni.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 26 Jan 2006 04:53:00 -0200
Message-Id: <1138258380.13564.100.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2006-01-24 às 12:25 +0100, Jiri Slaby escreveu:
> media video stradis memory fix
> 
> memset clears once set structure, there is actually no need for memset,
> because configure function do it for us. Next, vfree(NULL) is legal, so
> avoid useless labels.
> 
> Thanks Dave Jones for reporting this.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
	Applied to v4l-dvb.git. Thanks.

Cheers, 
Mauro.

