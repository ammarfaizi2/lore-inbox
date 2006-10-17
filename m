Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWJQXRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWJQXRy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 19:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWJQXRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 19:17:54 -0400
Received: from [81.2.110.250] ([81.2.110.250]:20874 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751083AbWJQXRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 19:17:53 -0400
Subject: Re: [PATCH] Undeprecate the sysctl system call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cal Peake <cp@absolutedigital.net>
Cc: Andrew Morton <akpm@osdl.org>, Randy Dunlap <rdunlap@xenotime.net>,
       Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Eric Biederman <ebiederm@xmission.com>
In-Reply-To: <Pine.LNX.4.64.0610171853160.25484@lancer.cnet.absolutedigital.net>
References: <453519EE.76E4.0078.0@novell.com>
	 <20061017091901.7193312a.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0610171401130.10587@lancer.cnet.absolutedigital.net>
	 <1161123096.5014.0.camel@localhost.localdomain>
	 <20061017150016.8dbad3c5.akpm@osdl.org>
	 <Pine.LNX.4.64.0610171853160.25484@lancer.cnet.absolutedigital.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 00:19:36 +0100
Message-Id: <1161127177.5014.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-17 am 19:09 -0400, ysgrifennodd Cal Peake:
> On Tue, 17 Oct 2006, Andrew Morton wrote:
> 
> > yes, it appears that we screwed that up, but I haven't got around to thinking about
> > it yet.
> 
> Well, here's a patch that hopefully solves the mess :)
> 
> From: Cal Peake <cp@absolutedigital.net>

Acked-by: Alan Cox <alan@redhat.com>

sysctl() should probably be described as obsolete in the manual pages
for sysctl(2) but it doesn't want pulling out of the kernel.

Alan

