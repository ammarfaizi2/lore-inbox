Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVGGWTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVGGWTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVGGVdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:33:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57543 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262271AbVGGVcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:32:08 -0400
Subject: Re: [PATCH] audit: file system auditing based on location and name
From: Arjan van de Ven <arjan@infradead.org>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Greg KH <greg@kroah.com>, "Timothy R. Chavez" <tinytim@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
In-Reply-To: <200507071548.37996.sgrubb@redhat.com>
References: <1120668881.8328.1.camel@localhost>
	 <200507071449.10271.sgrubb@redhat.com> <20050707190455.GA19570@kroah.com>
	 <200507071548.37996.sgrubb@redhat.com>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 23:31:49 +0200
Message-Id: <1120771909.3198.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Thu, 2005-07-07 at 15:48 -0400, Steve Grubb wrote:

> Tim's code lets you say I want change notification to this file only. The 
> notification follows the audit format with all relavant pieces of information 
> gathered at the time of the event and serialized with all other events.

well can't you sort of do that based on (selinux) security context of
the file already? after all that's part of the inode already. Isn't that
finegrained enough?

