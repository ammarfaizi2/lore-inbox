Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUFATew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUFATew (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUFATew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:34:52 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:25011 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265161AbUFATev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:34:51 -0400
Date: Tue, 1 Jun 2004 12:34:44 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
Message-ID: <20040601193444.GA24136@taniwha.stupidest.org>
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se> <c892nk$5pf$1@terminus.zytor.com> <16572.38987.239160.819836@alkaid.it.uu.se> <Pine.LNX.4.58.0406011020310.14095@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406011020310.14095@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 10:27:16AM -0700, Linus Torvalds wrote:

> And even function pointers should be safeish. The fact that some
> broken architecture (can you say "ia64"?) has totally idiotic
> calling conventions and requires the caller to load the GP value is
> _their_ problem.

ia64 function pointers are actually pointers to the 128-bit
descriptors so all pointers are still 64-bit.


  --cw
