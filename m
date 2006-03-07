Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWCGVY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWCGVY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWCGVY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:24:27 -0500
Received: from ns2.suse.de ([195.135.220.15]:42644 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932241AbWCGVY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:24:26 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 22:24:09 +0100
User-Agent: KMail/1.8
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <200603071134.52962.ak@suse.de> <200603071257.24234.ak@suse.de> <1141766085.5255.12.camel@serpentine.pathscale.com>
In-Reply-To: <1141766085.5255.12.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603072224.09976.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 22:14, Bryan O'Sullivan wrote:
> On Tue, 2006-03-07 at 12:57 +0100, Andi Kleen wrote:
> > > > True, I suppose. I should make it clear that these accessor functions
> > > > imply memory barriers, if indeed they do,
> > >
> > > They don't, but according to Documentation/DocBook/deviceiobook.tmpl
> > > they are performed by the compiler in the order specified.
> >
> > I don't think that's correct. Probably the documentation should
> > be fixed.
>
> That's why I hedged my words with "according to ..." :-)
>
> But on most arches those accesses do indeed seem to happen in-order.  On
> i386 and x86_64, it's a natural consequence of program store ordering.

Not true for reads on x86.

-Andi
