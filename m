Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVCZLpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVCZLpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 06:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVCZLpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 06:45:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51366 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262044AbVCZLo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 06:44:59 -0500
Subject: Re: Linux 2.4.30-rc2
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050326112256.GN30052@alpha.home.local>
References: <20050326004631.GC17637@logos.cnet>
	 <20050326112256.GN30052@alpha.home.local>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 12:44:53 +0100
Message-Id: <1111837493.8042.2.camel@laptopd505.fenrus.org>
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

On Sat, 2005-03-26 at 12:22 +0100, Willy Tarreau wrote:
> Marcelo,
> 
> here's a patch from Dave Jones, which is already in 2.6 and which I've
> used in my local tree for 6 months now. It removes a useless NULL check
> in zlib_inflateInit2_(), since 'z' is already dereferenced one line
> before the test. Can in go in 2.4.30 please ?

I don't see how such a cleanup-only patch would be a candidate for 2.4
at all, let alone to go into a -rc3 or a 2.4.30 final at this stage...

Can you explain why this one is so important that it has to go in so
late?


