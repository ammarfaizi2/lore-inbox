Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTFOQ5Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTFOQ5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:57:05 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:26640 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262386AbTFOQ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:56:32 -0400
Date: Sun, 15 Jun 2003 18:10:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Brownell <david-b@pacbell.net>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: GFDL in the kernel tree
Message-ID: <20030615181020.A19242@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Brownell <david-b@pacbell.net>, torvalds@transmeta.com,
	mochel@osdl.org, linux-kernel@vger.kernel.org
References: <20030615140758.A9390@infradead.org> <3EEC9946.9090308@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EEC9946.9090308@pacbell.net>; from david-b@pacbell.net on Sun, Jun 15, 2003 at 09:05:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 09:05:26AM -0700, David Brownell wrote:
> Christoph Hellwig wrote:
> > 2.5.71 introduces two GFDL-licensed files in the kernel tree...
> 
> A "grep" in Documentation/DocBook shows me three GFDL files,
> last time I grepped there were none.  So I was aware that
> adding one would likely raise some issues ... evidently
> a variety of people have noticed that GPL for docs/specs
> isn't the best solution.

My preferred license for documentation is 2clause BSD because
some of the GPL legalese is strange for docs at least..

But GFDL really is a horrible license.

> But there's a potential issue for kerneldoc for one particular
> structure, "usb_ctrlrequest", which was merged into 2.5 from a
> patch on 2/2/2002 ... I think I know who contributed that patch.
> If that author isn't willing to let that text be covered by
> GFDL, and for some reason I can't replace it with similar text
> that is (mostly pointing to the USB spec for details), I'll pull
> that bit out.  In short:  This particular issue is fixable.

Well, it is fixable but it's the best example of why am incompatible
documentation license is evil.

> Only when those sections are used.  Which none of those three
> files do; all that doc is Free (GPL-compatible) by Debian terms.
> (Modulo minor issues to be worked.)

debian-legacl had more issue, may they be minor or not.  The
biggest problem with the GFDL in the free software context is
it's GPL incompatiblity.

