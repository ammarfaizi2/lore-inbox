Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVASTy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVASTy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVASTy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:54:26 -0500
Received: from canuck.infradead.org ([205.233.218.70]:27660 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261695AbVASTyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:54:12 -0500
Subject: Re: thoughts on kernel security issues
From: Arjan van de Ven <arjan@infradead.org>
To: Valdis.Kletnieks@vt.edu
Cc: John Richard Moser <nigelenki@comcast.net>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>
References: <20050112205350.GM24518@redhat.com>
	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	 <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	 <20050113082320.GB18685@infradead.org>
	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
	 <1105635662.6031.35.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
	 <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu>
	 <41EE96E7.3000004@comcast.net>
	 <1106157152.6310.171.camel@laptopd505.fenrus.org>
	 <41EEABEF.5000503@comcast.net>
	 <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 20:53:51 +0100
Message-Id: <1106164432.6310.195.camel@laptopd505.fenrus.org>
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


> 700K. In one patch. If PAX is available for 2.6.10 by itself, it certainly
> hasn't been posted to http://pax.grsecurity.net - that's still showing a 2.6.7
> patch.  But even there, that's a single monolithic 280K patch.  That's never
> going to get merged, simply because *nobody* can review a single patch that big.
> 
> Now look at http://www.kernel.org/pub/linux/kernel/people/arjan/execshield/.
> 4 separate hunks, the biggest is under 7K.  Other chunks of similar size
> for non-exec stack and NX support are already merged.
> 
> And why were they merged?  Because they showed up in 4-8K chunks.
>   
note to readers: I'm still not happy about the split up and want to
split this up even further in smaller pieces; the split up there is only
a first order split.


