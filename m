Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWGYWsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWGYWsH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWGYWsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:48:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60553 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030206AbWGYWsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:48:05 -0400
Subject: Re: [PATCH] CCISS: Don't print driver version until we actually
	find a device
From: Arjan van de Ven <arjan@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       Mike Miller <mike.miller@hp.com>, iss_storagedev@hp.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490607251543w7496864dtd587abc45b93394a@mail.gmail.com>
References: <200607251636.42765.bjorn.helgaas@hp.com>
	 <9a8748490607251543w7496864dtd587abc45b93394a@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 26 Jul 2006 00:47:55 +0200
Message-Id: <1153867675.8932.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 00:43 +0200, Jesper Juhl wrote:
> On 26/07/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > If we don't find any devices, we shouldn't print anything.
> >
> I disagree.
> I find it quite nice to be able to see that the driver loaded even if
> it finds nothing. At least then when there's a problem, I can quickly
> see that at least it is not because I didn't forget to load the
> driver, it's something else. Saves time since I can start looking for
> reasons why the driver didn't find anything without first spending
> additional time checking if I failed to cause it to load for some
> reason.

I'll add a second reason: it is a REALLY nice property to be able to see
which driver is started last in case of a crash/hang, so that the guilty
party is more obvious..

> 
> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

