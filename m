Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVATS6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVATS6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVATS4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:56:04 -0500
Received: from canuck.infradead.org ([205.233.218.70]:30737 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261678AbVATSze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:55:34 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41EFF581.6050108@comcast.net>
References: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	 <20050113082320.GB18685@infradead.org>
	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
	 <1105635662.6031.35.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
	 <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu>
	 <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu>
	 <41EEA86D.7020108@comcast.net> <20050120104451.GE12665@elte.hu>
	 <41EFF581.6050108@comcast.net>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 19:55:04 +0100
Message-Id: <1106247305.6742.87.camel@laptopd505.fenrus.org>
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

On Thu, 2005-01-20 at 13:16 -0500, John Richard Moser wrote:
> Even when the tagging is all automatic, to really deploy a competantly
> formed system you have to review the results of the automated tagging.
> It's a bit easier in most cases to automate-and-review, but it still has
> to be done.  I think in the case of PaX markings, the maintenance
> overhead of manually marking binaries is minimal enough that looking for
> mistakes would be more work than working from an already known and
> familiar base.


well, marking with PT_GNU_STACK is similar, execstack tool (part of the
prelink package) both shows and can change the existing marking of
binaries/libs.

How is that much different to what pax provides?




