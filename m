Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVFOVs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVFOVs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFOVqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:46:43 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:25752 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261609AbVFOVpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:45:19 -0400
Date: Wed, 15 Jun 2005 16:50:19 -0500
From: serue@us.ibm.com
To: Chris Wright <chrisw@osdl.org>
Cc: serue@us.ibm.com, James Morris <jmorris@redhat.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Tom Lendacky <toml@us.ibm.com>,
       Greg KH <greg@kroah.com>, Emily Rattlif <emilyr@us.ibm.com>,
       Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
Message-ID: <20050615215019.GB3660@serge.austin.ibm.com>
References: <1118846413.2269.18.camel@secureip.watson.ibm.com> <Xine.LNX.4.44.0506151601310.27162-100000@thoron.boston.redhat.com> <20050615204936.GA3517@serge.austin.ibm.com> <20050615205926.GP9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615205926.GP9046@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> The primary purpose of the hooks is access control.  Some of them, of
> course, are helpers to keep labels coherent.  IIRC, James objected
> because the measurement data was simply collected from these hooks.

Ok, so to be clear, any module which does not directly impose some form
of access control is not eligible for an LSM?

(in that case that clearly settles the issue)

thanks,
-serge
