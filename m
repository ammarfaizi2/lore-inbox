Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbUK3Hqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbUK3Hqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 02:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUK3Hqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 02:46:33 -0500
Received: from canuck.infradead.org ([205.233.218.70]:31762 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262004AbUK3HqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 02:46:18 -0500
Subject: Re: [PATCH] CKRM: 3/10 CKRM:  Core ckrm, rcfs
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <20041129220047.GC19892@kroah.com>
References: <E1CYqYe-00057g-00@w-gerrit.beaverton.ibm.com>
	 <20041129220047.GC19892@kroah.com>
Content-Type: text/plain
Message-Id: <1101800761.2640.29.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 08:46:02 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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

On Mon, 2004-11-29 at 14:00 -0800, Greg KH wrote:
> > +struct rcfs_functions rcfs_fn;
> > +EXPORT_SYMBOL_GPL(rcfs_fn);
> 
> I don't understand.  Portions of ckrm are released under the LGPL, while
> others are under the GPL?  Why the difference?

the headers are LGPL it seems, the code GPL. Quite a sensible
arrangement imo


