Return-Path: <linux-kernel-owner+w=401wt.eu-S932510AbWLSAn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWLSAn1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWLSAn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:43:26 -0500
Received: from ozlabs.org ([203.10.76.45]:52872 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932510AbWLSAn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:43:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17799.13724.579027.764565@cargo.ozlabs.ibm.com>
Date: Tue, 19 Dec 2006 11:43:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, Ricardo Galli <gallir@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
In-Reply-To: <Pine.LNX.4.64.0612181554430.3479@woody.osdl.org>
References: <200612161927.13860.gallir@gmail.com>
	<Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	<orwt4qaara.fsf@redhat.com>
	<Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
	<orpsah6m3s.fsf@redhat.com>
	<Pine.LNX.4.64.0612181134260.3479@woody.osdl.org>
	<or64c96ius.fsf@redhat.com>
	<Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
	<17799.10706.834077.676728@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0612181554430.3479@woody.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> 
> On Tue, 19 Dec 2006, Paul Mackerras wrote:
> >
> > There is in fact a pretty substantial non-technical difference between
> > static and dynamic linking.  If I create a binary by static linking
> > and I include some library, and I distribute that binary to someone
> > else, the recipient doesn't need to have a separate copy of the
> > library, because they get one in the binary.
> 
> I agree, and I do agree that it's a real difference. 
> 
> I personally think that it's the "aggregation" issue, not a "derivation" 
> issue, but I'll freely admit that it's just my personal view of the 
> situation.

I think the critical issue is whether any human creativity is required
to establish derivation.

Clearly there is some modification and adaptation that ld does to a
library in the process of linking it into a binary, and ld is unlike
mkisofs or gzip in that you can't extract the library in its original
form (or any form suitable for linking with another program) from the
output of ld --static.

The question is whether it matters that the process that ld does is
mechanical in nature.  This is possibly an area where you'll get a
different answer in different jurisdictions.  I believe that in the
US, some creative input is required to establish copyright, whereas in
Australia, only "effort" is needed.  I don't know whether that affects
the definition of "derived work".

I personally would think that a mechanical process of modification
*does* create a derived work, but it would take a court of law or a
legislature to make an authoritative decision, I guess.

Paul.
