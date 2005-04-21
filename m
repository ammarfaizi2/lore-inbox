Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVDUUb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVDUUb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVDUUb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:31:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261859AbVDUUb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:31:28 -0400
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
	verbs implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, Andy Isaacson <adi@hexapodia.org>,
       Troy Benjegerdes <hozer@hozed.org>, Bernhard Fischer <blist@aon.at>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20050421202503.GO493@shell0.pdx.osdl.net>
References: <20050421173821.GA13312@hexapodia.org>
	 <4267F367.3090508@ammasso.com> <20050421195641.GB13312@hexapodia.org>
	 <4268080E.3000303@ammasso.com> <20050421201227.GI23013@shell0.pdx.osdl.net>
	 <426809C3.7010101@ammasso.com>  <20050421202503.GO493@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 22:30:57 +0200
Message-Id: <1114115458.6277.84.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Thu, 2005-04-21 at 13:25 -0700, Chris Wright wrote:
> * Timur Tabi (timur.tabi@ammasso.com) wrote:
> > It works with every kernel I've tried.  I'm sure there are plenty of kernel 
> > configuration options that will break our driver.  But as long as all the 
> > distros our customers use work, as well as reasonably-configured custom 
> > kernels, we're happy.
> > 
> 
> Hey, if you're happy (and, as you said, you don't intend to merge that
> bit), I'm happy ;-)


yeah... drivers giving unprivileged processes more privs belong on
bugtraq though, not in the core kernel :)


