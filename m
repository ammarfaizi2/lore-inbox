Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVCTJ23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVCTJ23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 04:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVCTJ22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 04:28:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40416 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262058AbVCTJ2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 04:28:20 -0500
Subject: Re: Nasty ReiserFS bug in 2.6.12-rc1, 2.6.12-rc1-bk1
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Bob Gill <gillb4@telusplanet.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050319224549.50ebd7b2.akpm@osdl.org>
References: <1111267079.7961.10.camel@localhost.localdomain>
	 <20050319224549.50ebd7b2.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 20 Mar 2005 10:28:12 +0100
Message-Id: <1111310893.13192.31.camel@laptopd505.fenrus.org>
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


> At a guess I'd say that scsi did something horrid and tripped up the
> anticipatory scheduler code.

or... his nvidia module scribbled somewhere horrible ;)

