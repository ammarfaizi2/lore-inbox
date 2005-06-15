Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVFOWx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVFOWx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVFOWx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:53:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261624AbVFOWtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:49:49 -0400
Date: Wed, 15 Jun 2005 15:49:21 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Tom Lendacky <toml@us.ibm.com>,
       Greg KH <greg@kroah.com>, Emily Rattlif <emilyr@us.ibm.com>,
       Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <20050615224921.GT9046@shell0.pdx.osdl.net>
References: <1118846413.2269.18.camel@secureip.watson.ibm.com> <Xine.LNX.4.44.0506151601310.27162-100000@thoron.boston.redhat.com> <20050615204936.GA3517@serge.austin.ibm.com> <20050615205926.GP9046@shell0.pdx.osdl.net> <20050615215019.GB3660@serge.austin.ibm.com> <20050615215301.GQ9046@shell0.pdx.osdl.net> <20050615224241.GB3492@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615224241.GB3492@IBM-BWN8ZTBWA01.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Quoting Chris Wright (chrisw@osdl.org):
> > * serue@us.ibm.com (serue@us.ibm.com) wrote:
> > > Quoting Chris Wright (chrisw@osdl.org):
> > > > The primary purpose of the hooks is access control.  Some of them, of
> > > > course, are helpers to keep labels coherent.  IIRC, James objected
> > > > because the measurement data was simply collected from these hooks.
> > > 
> > > Ok, so to be clear, any module which does not directly impose some form
> > > of access control is not eligible for an LSM?
> > 
> > That's exactly the intention, yes.
> 
> Ok, thanks.
> 
> I thought it was intended to be more general than that - in fact I
> specifically thought it was not intended to be purely for single machine
> authentication decisions within a single kernel module, but that anything
> which would aid in enabling new security features, locally or remotely,
> would be game.  (Which - it means nothing - but I would clearly have
> preferred :)

The problem with being more general is it becomes a more attractive
target for abuse.

thanks,
-chris
