Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVAQNnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVAQNnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVAQNnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:43:03 -0500
Received: from canuck.infradead.org ([205.233.218.70]:62993 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262799AbVAQNmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:42:45 -0500
Subject: Re: [PATCH] revert- sys_setaltroot
From: Arjan van de Ven <arjan@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <1105968934.26551.347.camel@hades.cambridge.redhat.com>
References: <200410261928.i9QJS7h3011015@hera.kernel.org>
	 <1103710694.6111.127.camel@localhost.localdomain>
	 <20041222030304.07bb036e.akpm@osdl.org>
	 <1105968934.26551.347.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 14:42:36 +0100
Message-Id: <1105969356.6304.100.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 13:35 +0000, David Woodhouse wrote:
> On Wed, 2004-12-22 at 03:03 -0800, Andrew Morton wrote:
> > There were security problems and suggestions that a namespace-based
> > approach would be better.   umm, have a random sprinkle of emails:
> 
> The security problems have been addressed, and the namespace-based
> approach was never coherently explained. I can't see how such would
> work.

see viro's recent proposal for bindmounts and the like.


