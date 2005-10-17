Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVJQT2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVJQT2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVJQT2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:28:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57515 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751173AbVJQT2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:28:36 -0400
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com,
       muli@il.ibm.com, jdmason@us.ibm.com
In-Reply-To: <200510172109.54066.ak@suse.de>
References: <20051017093654.GA7652@localhost.localdomain>
	 <20051017184523.GB26239@granada.merseine.nu>
	 <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
	 <200510172109.54066.ak@suse.de>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 21:15:37 +0200
Message-Id: <1129576538.2907.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 21:09 +0200, Andi Kleen wrote:
> On Monday 17 October 2005 21:04, Linus Torvalds wrote:
> 
> > So the only thing that worried me (and made me ask whether there might be
> > machines where it doesn't work) is if some machines might have their high
> > memory (or no memory at all) on NODE(0). It does sound unlikely, but I
> > simple don't know what kind of strange NUMA configs there are out there.
> 
> It could happen in VirtualIron (they seem to interleave node 0 over many nodes 
> to get equal use of lowmem in 32bit NUMA), but should not in x86-64..
>  
does VirtualIron work with kernel.org kernels at all?


