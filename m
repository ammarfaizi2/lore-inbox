Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbTEMSNb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTEMSN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:13:29 -0400
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:56500 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id S261866AbTEMSMg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:12:36 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Date: Tue, 13 May 2003 13:25:17 -0500
Message-ID: <B578DAA4FD40684793C953B491D4879174D3B9@umr-mail7.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG support
Thread-Index: AcMZfI/IAMvYHDaeT+e5LB51/O/knAAAFfjg
From: "Neulinger, Nathan" <nneul@umr.edu>
To: "David Howells" <dhowells@warthog.cambridge.redhat.com>,
       "Jan Harkes" <jaharkes@cs.cmu.edu>,
       "Linus Torvalds" <torvalds@transmeta.com>,
       "David Howells" <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If someone obtains my user id on in any way (i.e. weak password/
> > bufferoverflow/ root exploit), he should not be allowed to 
> use or access
> > my tokens as he hasn't proven his identity. In this case he 
> would either
> > still be in his original process authentication group, or a new and
> > empty PAG. But definitely not in any of my authentication groups.
> > 
> > Which is also why joining a PAG should never be allowed.
> 
> Someone asked for it, but I suspect if allowed at all it may 
> be best that this
> ability is governed by its own capability bit and also that 
> the security
> interface should be consulted.

Definately. This is only allowed for root in any case. (Or the cap as
you describe.)

-- Nathan
