Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVA1TJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVA1TJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVA1TEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:04:10 -0500
Received: from canuck.infradead.org ([205.233.218.70]:16141 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261503AbVA1TBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:01:49 -0500
Subject: Re: make flock_lock_file_wait static
From: Arjan van de Ven <arjan@infradead.org>
To: paulmck@us.ibm.com
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050128141446.GA1868@us.ibm.com>
References: <1105345168.4171.11.camel@laptopd505.fenrus.org>
	 <1105346324.4171.16.camel@laptopd505.fenrus.org>
	 <1105367014.11462.13.camel@lade.trondhjem.org>
	 <1105432299.3917.11.camel@laptopd505.fenrus.org>
	 <1105471004.12005.46.camel@lade.trondhjem.org>
	 <1105472182.3917.49.camel@laptopd505.fenrus.org>
	 <20050125185812.GA1499@us.ibm.com>
	 <1106730061.6307.62.camel@laptopd505.fenrus.org>
	 <20050126160715.GB1266@us.ibm.com>
	 <1106765983.6307.134.camel@laptopd505.fenrus.org>
	 <20050128141446.GA1868@us.ibm.com>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 20:01:34 +0100
Message-Id: <1106938895.7776.33.camel@laptopd505.fenrus.org>
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

On Fri, 2005-01-28 at 06:14 -0800, Paul E. McKenney wrote:
> On Wed, Jan 26, 2005 at 07:59:42PM +0100, Arjan van de Ven wrote:
> > On Wed, 2005-01-26 at 08:07 -0800, Paul E. McKenney wrote:
> > 
> > > > Another question: is the SDD module even available for mainline kernels,
> > > > or is it only available for distribution kernels ?
> > > 
> > > Distributions only.
> > 
> > don't you think it's a bit weird/offensive to ask for exports in the
> > mainline kernel.org kernel while all you care about is certain vendor
> > kernels and never plan to provide it for mainline????
> 
> In my experience, the only way to get exports into a major distribution
> is to get them into mainline kernel.org.  If you can get Red Hat to
> change its stance on this, works for me!

so a business problem between IBM and Red Hat is reason to bloat
everyones kernel ????

that's sooo wrong.

(and no I cannot change the RH policy) 


