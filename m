Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbUK3Hob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUK3Hob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 02:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUK3Hob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 02:44:31 -0500
Received: from canuck.infradead.org ([205.233.218.70]:29714 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262002AbUK3Ho2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 02:44:28 -0500
Subject: Re: [PATCH] CKRM: 2/10 CKRM:  Accurate delay accounting
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Rik van Riel <riel@redhat.com>,
       Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <20041129213825.GB19892@kroah.com>
References: <E1CYqY1-00057E-00@w-gerrit.beaverton.ibm.com>
	 <20041129213825.GB19892@kroah.com>
Content-Type: text/plain
Message-Id: <1101800656.2640.27.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 08:44:16 +0100
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

On Mon, 2004-11-29 at 13:38 -0800, Greg KH wrote:

> So LGPL code can use EXPORT_SYMBOL_GPL?

yes it can; because LGPL code linked into the kernel (dynamic/static) is
used under the terms of the GPL (as per the LGPL license)


