Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVK0TMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVK0TMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVK0TMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:12:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13213 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750938AbVK0TMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:12:30 -0500
Subject: Re: [BUG]: Software compiling occasionlly hangs under
	2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
From: Arjan van de Ven <arjan@infradead.org>
To: Tarkan Erimer <tarkane@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
	 <1132917564.7068.41.camel@laptopd505.fenrus.org>
	 <9611fa230511270317led5b915h7daae3ef1287f86d@mail.gmail.com>
	 <1133092701.2853.0.camel@laptopd505.fenrus.org>
	 <9611fa230511271108m46389ee6w7ec6b5b40b1e23dd@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 27 Nov 2005 20:12:27 +0100
Message-Id: <1133118747.2853.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-27 at 19:08 +0000, Tarkan Erimer wrote:
> Hi again,
> 
> On 11/27/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > which process again was hanging?
> >
> > (and maybe also post an lsmod output just to get an idea of which
> > modules/drivers are in play)
> 
> I investigated the issue a bit  more. When the system under heavy load
> (%100 cpu usage), hard lock up/complete freeze occures a few minutes later.
hmm this in theory could also be a thermal issue...


