Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVCJI5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVCJI5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVCJI5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:57:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8597 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262449AbVCJI5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:57:18 -0500
Subject: Re: Can I get 200M contiguous physical memory?
From: Arjan van de Ven <arjan@infradead.org>
To: Jason Luo <abcd.bpmf@gmail.com>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
In-Reply-To: <c4b38ec40503100049190d5498@mail.gmail.com>
References: <c4b38ec4050310001061c62b9d@mail.gmail.com>
	 <20050310081634.GA29516@taniwha.stupidest.org>
	 <c4b38ec40503100049190d5498@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 09:57:10 +0100
Message-Id: <1110445030.6291.57.camel@laptopd505.fenrus.org>
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

On Thu, 2005-03-10 at 16:49 +0800, Jason Luo wrote:
> thanks!
> A data acquisition card. In DMA mode, the card need 200M contiguous
> memory for DMA.
> it's driver in windows can do it. so custom ask us to support it.
> are there a way although it'is unpopular?

not really unless your card can do scatter gather...


(or want to reserve memory at the boot commandline and then do really
really evil hacks)

