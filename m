Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVAGHds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVAGHds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVAGHds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:33:48 -0500
Received: from canuck.infradead.org ([205.233.218.70]:51977 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261300AbVAGHdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:33:47 -0500
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
From: Arjan van de Ven <arjan@infradead.org>
To: paulmck@us.ibm.com
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com
In-Reply-To: <20050106210408.GM1292@us.ibm.com>
References: <20050106190538.GB1618@us.ibm.com>
	 <1105039259.4468.9.camel@laptopd505.fenrus.org>
	 <20050106201531.GJ1292@us.ibm.com>
	 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 08:33:32 +0100
Message-Id: <1105083213.4179.1.camel@laptopd505.fenrus.org>
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

On Thu, 2005-01-06 at 13:04 -0800, Paul E. McKenney wrote:
> On Thu, Jan 06, 2005 at 08:32:59PM +0000, Al Viro wrote:
> > On Thu, Jan 06, 2005 at 12:15:31PM -0800, Paul E. McKenney wrote:
> > > Yep, you win the prize, it is MVFS.
> > > 
> > > This is the usual port of an existing body of code to the Linux kernel.
> > > It is not asking for a new export, only restoration of a previously existing
> > > export.
> > 
> > Sorry, but "our code is badly misdesigned" does not make a valid excuse
> > when you have been told, repeatedly, by many people, for at least a year
> > that you needed to sanitize your design.
> 
> The obvious searches did not find this for me.  Any pointers so that
> I can bring to the MVFS guys' attention any alternatives that might
> have been recommended?

eh maybe a weird question, but why are you and not the MVFS guys asking
for this export then? They can probably better explain why they need
it ....

