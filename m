Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVFOWn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVFOWn7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVFOWn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:43:58 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10924 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261609AbVFOWmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:42:43 -0400
Date: Wed, 15 Jun 2005 17:42:41 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: James Morris <jmorris@redhat.com>, Reiner Sailer <sailer@watson.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Tom Lendacky <toml@us.ibm.com>,
       Greg KH <greg@kroah.com>, Emily Rattlif <emilyr@us.ibm.com>,
       Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <20050615224241.GB3492@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1118846413.2269.18.camel@secureip.watson.ibm.com> <Xine.LNX.4.44.0506151601310.27162-100000@thoron.boston.redhat.com> <20050615204936.GA3517@serge.austin.ibm.com> <20050615205926.GP9046@shell0.pdx.osdl.net> <20050615215019.GB3660@serge.austin.ibm.com> <20050615215301.GQ9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615215301.GQ9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> * serue@us.ibm.com (serue@us.ibm.com) wrote:
> > Quoting Chris Wright (chrisw@osdl.org):
> > > The primary purpose of the hooks is access control.  Some of them, of
> > > course, are helpers to keep labels coherent.  IIRC, James objected
> > > because the measurement data was simply collected from these hooks.
> > 
> > Ok, so to be clear, any module which does not directly impose some form
> > of access control is not eligible for an LSM?
> 
> That's exactly the intention, yes.

Ok, thanks.

I thought it was intended to be more general than that - in fact I
specifically thought it was not intended to be purely for single machine
authentication decisions within a single kernel module, but that anything
which would aid in enabling new security features, locally or remotely,
would be game.  (Which - it means nothing - but I would clearly have
preferred :)

Thanks for setting me straight.

-serge

