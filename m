Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVBRNNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVBRNNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 08:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBRNNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 08:13:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36261 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261352AbVBRNNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 08:13:40 -0500
Subject: Re: Please open sysfs symbols to proprietary modules
From: Arjan van de Ven <arjan@infradead.org>
To: parker@citynetwireless.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050217231304.GA18940@core.citynetwireless.net>
References: <20050217231304.GA18940@core.citynetwireless.net>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 14:13:11 +0100
Message-Id: <1108732392.4664.179.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 17:13 -0600, parker@citynetwireless.net wrote:
> On Thu, 03 Feb 2005 09:41:00 +0100, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Wed, 2005-02-02 at 17:56 -0500, Pavel Roskin wrote:
> > > Hello!
> > >
> > > I'm writing a module under a proprietary license.  I decided to use sysfs
> > > to do the configuration.  Unfortunately, all sysfs exports are available
> > > to GPL modules only because they are exported by EXPORT_SYMBOL_GPL.
> > 
> > I suggest you talk to a lawyer and review the general comments about
> > binary modules with him (http://people.redhat.com/arjanv/COPYING.modules
> > for example). You are writing an addition to linux from scratch, and it
> > is generally not considered OK to do that in binary form (I certainly do
> > not consider it OK).
> 
> So what about companies like ImageStream who write proprietary Linux network
> drivers for their hardware from scratch with no previous ports from another OS?

Note that "has a previous port" is not enough for me to consider a
proprietary driver "ok". 

Anyway you asked... if your description is accurate then yes I consider
those modules (if they are distributed of course) a violation of the
license of the code I contributed to the kernel.


