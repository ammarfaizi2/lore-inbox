Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUF1G6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUF1G6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 02:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUF1G6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 02:58:15 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:57789 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S264737AbUF1G6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 02:58:14 -0400
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Mon, 28 Jun 2004 08:55:08 +0200
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040628065506.GA5557@kiste>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org> <1088290477.3790.2.camel@localhost.localdomain> <20040627000541.GA13325@taniwha.stupidest.org> <pan.2004.06.27.12.00.03.857572@smurf.noris.de> <20040627224115.GA22532@taniwha.stupidest.org> <20040628012407.GC4648@kiste> <20040628054227.GB4025@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628054227.GB4025@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040523i
X-Smurf-Spam-Score: -3.8 (---)
X-Smurf-Spam-Report: Spam detection software, running on the system "server.smurf.noris.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, Chris Wedgwood: > I think the approach is to look
	at _why_ people need jiffies and > change this to a cleaner less
	low-level API using accessor > functions/macros. > That would be the
	correct long-term approach, true. [...] 
	Content analysis details:   (-3.8 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Chris Wedgwood:
> I think the approach is to look at _why_ people need jiffies and
> change this to a cleaner less low-level API using accessor
> functions/macros.
> 
That would be the correct long-term approach, true. 

However, going over 5000 jiffies usages and re-doing all of them doesn't
happen overnight, and I do suspect that some people want their embedded
clockless systems to run Linux 2.4 or 2.6, rather than 2.8...

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
