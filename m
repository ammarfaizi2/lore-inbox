Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVAEB4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVAEB4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVAEB4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:56:00 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12928 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262174AbVAEBzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:55:35 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050104175043.H469@build.pdx.osdl.net>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
	 <1104862614.8255.1.camel@krustophenia.net>
	 <20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us>
	 <1104865198.8346.8.camel@krustophenia.net>
	 <1104878646.17166.63.camel@localhost.localdomain>
	 <20050104175043.H469@build.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 20:55:31 -0500
Message-Id: <1104890131.18410.32.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 17:50 -0800, Chris Wright wrote:
> * Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> > 
> > The problem with uid/gid based hacks is that they get really ugly to
> > administer really fast. Especially once you have users who need realtime
> > and hugetlb, and users who need one only.
> 
> I don't believe the hugetlb gid stuff is useful anymore.  It should be
> handled nicely via rlimits.

The last time I checked users could belong to more than one group.  Am I
missing something?

Lee

