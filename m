Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWEIPd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWEIPd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWEIPd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:33:56 -0400
Received: from host217-46-213-187.in-addr.btopenworld.com ([217.46.213.187]:4789
	"EHLO help.basilica.co.uk") by vger.kernel.org with ESMTP
	id S1751453AbWEIPd4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:33:56 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 9 May 2006 16:34:13 +0100
Message-ID: <8941BE5F6A42CC429DA3BC4189F9D4420A13B0@bashdad01.hd.basilica.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space probes
Thread-Index: AcZzfAhKvSxvNdiESDOcmVtJt6SfWgAAelMw
From: "Khushil Dep" <khushil.dep@help.basilica.co.uk>
To: "Christoph Hellwig" <hch@infradead.org>,
       "Richard J Moore" <richardj_moore@uk.ibm.com>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Prasanna S Panchamukhi" <prasanna@in.ibm.com>, <suparna@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"I'd love to see the crack that's handed out at your group." - *lol* man
I gotta steal that for my tag line! *rotfl*

*cough* ahem - sorry ;-)

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Christoph
Hellwig
Sent: 09 May 2006 16:19
To: Richard J Moore
Cc: Christoph Hellwig; akpm@osdl.org; linux-kernel@vger.kernel.org;
Prasanna S Panchamukhi; suparna@in.ibm.com
Subject: Re: [RFC] [PATCH 3/6] Kprobes: New interfaces for user-space
probes

On Tue, May 09, 2006 at 04:11:36PM +0100, Richard J Moore wrote:
> Christoph, what are you asking for here? Surely not the RPN
interpreter. I
> thought everyone agreed that that was massive bloatware and that a
binary
> interface viz kprobes was a much better implementation.

I don't know what interface would be best.  I'm not pushing this big
pile
of junk either.  Unless you find a suitable interface that you include
in
the patchkit we're not gonna add it, even after it's been rewritten to
be
sane.  So if you care to get this in find a suitable interface.

why the hell do you guys expect to get a huge piele of flaky code
integrate
that slows down pagecaches and adds thousands of lines of undebuggable
and
untestable code without submitting something that actually calls it.

I'd love to see the crack that's handed out at your group.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
