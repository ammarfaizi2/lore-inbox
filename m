Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTJACIa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 22:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTJACIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 22:08:30 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26386
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261875AbTJACI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 22:08:29 -0400
Date: Tue, 30 Sep 2003 19:08:45 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20031001020845.GA13051@matchmail.com>
Mail-Followup-To: "Nakajima, Jun" <jun.nakajima@intel.com>,
	Andrew Morton <akpm@osdl.org>, Jamie Lokier <jamie@shareable.org>,
	davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
	richard.brunner@amd.com
References: <7F740D512C7C1046AB53446D3720017304AFCD@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AFCD@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 06:54:06PM -0700, Nakajima, Jun wrote:
> > I think we should fix up userspace.
> What do you mean by this? Patch user code at runtime (it's much more
> complex than it sounds) or remove prefetch instructions from userspace?

No, just make sure that userspace doesn't see the exceptions that the errata
will produce in obscure cases.  It is all explained in several threads about
this.  Search for "Andi Kleen" and "prefetch".
