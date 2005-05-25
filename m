Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVEYP4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVEYP4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVEYP4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:56:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2997 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262352AbVEYP4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:56:12 -0400
Subject: Re: Add "FORTIFY_SOURCE" to the linux kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, arjan@pentafluge.infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61.0505251736550.997@scrub.home>
References: <20050525084332.GA16865@pentafluge.infradead.org>
	 <4294891E.4070702@vc.cvut.cz>
	 <1117032436.6010.76.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0505251736550.997@scrub.home>
Content-Type: text/plain
Date: Wed, 25 May 2005 17:56:02 +0200
Message-Id: <1117036563.6010.80.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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

On Wed, 2005-05-25 at 17:40 +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 25 May 2005, Arjan van de Ven wrote:
> 
> > Or, alternatively, in your module UNDEF the config option before
> > including these headers.
> 
> Eeek, you don't mean this seriously?

alternative is a define "DONT_GIVE_ME_GPL_STUFF" or something... that
could work too.


