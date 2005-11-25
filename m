Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVKYTNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVKYTNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbVKYTNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:13:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18623 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751457AbVKYTNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:13:53 -0500
Subject: Re: 2.6.14-rt4: via DRM errors
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, dri-devel@lists.sourceforge.net,
       Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1132945536.20390.39.camel@mindpipe>
References: <1132807985.1921.82.camel@mindpipe>
	 <1132829378.3473.11.camel@mindpipe>
	 <19379.192.138.116.230.1132836621.squirrel@192.138.116.230>
	 <200511240731.56147.jbarnes@virtuousgeek.org>
	 <1132945536.20390.39.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 20:13:40 +0100
Message-Id: <1132946020.8990.7.camel@laptopd505.fenrus.org>
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

On Fri, 2005-11-25 at 14:05 -0500, Lee Revell wrote:
> On Thu, 2005-11-24 at 07:31 -0800, Jesse Barnes wrote:
> > Sounds interesting, but that would be card specific, right?  I mean,
> > on some cards the 2d and 3d locks would have to be the same because of
> > shared state or whatever, for example. 
> 
> Not especially, that's how most Linux drivers work.  The locking in the
> DRM seems unusually coarse grained.

of course sometimes having less but more coarse locks is actually
faster. Taking/dropping a lock is not free. far from it. 

