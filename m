Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbUBWXEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbUBWXAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:00:44 -0500
Received: from hera.kernel.org ([63.209.29.2]:5336 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262078AbUBWW4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:56:33 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Intel vs AMD x86-64
Date: Mon, 23 Feb 2004 22:56:29 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1e0et$fb7$1@terminus.zytor.com>
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077576989 15720 63.209.29.3 (23 Feb 2004 22:56:29 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 23 Feb 2004 22:56:29 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
>
> 
> 
> On Mon, 23 Feb 2004, Rik van Riel wrote:
> > On Sat, 21 Feb 2004, Linus Torvalds wrote:
> > 
> > > I'm really happy Intel finally got with the program,
> > 
> > With the program?  They still don't have an IOMMU ;)
> 
> Hmm.. Let's see what their chipsets will look like for this thing. Since
> they don't have an integrated memory controller, they can't very well do
> the IOMMU on the CPU, now can they?
> 
> So you can't blame them for that.
> 

No, it should be in the northbridge.  Note that *most* AGPGARTs work
as IOMMUs, but not all.  They may not be 64 bits, though.

	-hpa
