Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVBSJjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVBSJjN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVBSJhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:37:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19379 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261688AbVBSJgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 04:36:07 -0500
Subject: Re: Should kirqd work on HT?
From: Arjan van de Ven <arjan@infradead.org>
To: ncunningham@cyclades.com
Cc: kwijibo@zianet.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108803727.4098.31.camel@desktop.cunningham.myip.net.au>
References: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
	 <4216E043.1060507@zianet.com>
	 <1108803727.4098.31.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 10:36:02 +0100
Message-Id: <1108805762.6304.73.camel@laptopd505.fenrus.org>
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

On Sat, 2005-02-19 at 20:02 +1100, Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2005-02-19 at 17:44, Kwijibo wrote:
> > My guess is that irqbalance is not running.
> 
> No. It is.
> 
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> root       301  0.0  0.0     0    0 ?        SW   16:52   0:00 [kirqd]
> 
> The debugging info reports that it doesn't think it's worth doing the
> balancing.

I guess the question was about the userspace irqbalance....



