Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWCTSsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWCTSsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 13:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWCTSsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 13:48:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62673 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751276AbWCTSsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 13:48:11 -0500
Subject: Re: [openib-general] Re: 2.6.16-rc6-mm2: new RDMA CM
	EXPORT_SYMBOL's
From: Arjan van de Ven <arjan@infradead.org>
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: Matthew Frost <artusemrys@sbcglobal.net>, Andrew Morton <akpm@osdl.org>,
       Sean Hefty <sean.hefty@intel.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, bunk@stusta.de
In-Reply-To: <441EF553.2080803@ichips.intel.com>
References: <20060319041153.38692.qmail@web81904.mail.mud.yahoo.com>
	 <441EF553.2080803@ichips.intel.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 19:47:53 +0100
Message-Id: <1142880473.3114.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>Please explain the thinking behind the choice of a non-GPL export. 
> >>(Yes, we discussed this when inifiniband was first merged, but it
> >>doesn't hurt to reiterate).
> 
> The agreement made within the OpenIB community, from where this code originates, 
> is that all source code be licensed under a dual license of BSD/GPL.  I am not a 
> lawyer, so I don't know the implications of changing the exports to be GPL only, 
> given the OpenIB license.  But my understanding is that makes using those 
> functions less attractive.

no actually ;)

but I understood OpenIB to be "GPL when used in the linux kernel,
optionally BSD when outside linux". Since EXPORT_SYMBOL is highly linux
kernel specific... the _GPL should be just fine

 

