Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbTERMn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 08:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTERMn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 08:43:58 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:7302 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S262036AbTERMn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 08:43:56 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [OOPS] 2.5.69-mm6
References: <20030516015407.2768b570.akpm@digeo.com>
	<87fznfku8z.fsf@lapper.ihatent.com>
	<20030516180848.GW8978@holomorphy.com>
	<20030516185638.GA19669@suse.de>
	<20030516191711.GX8978@holomorphy.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 18 May 2003 14:57:04 +0200
In-Reply-To: <20030516191711.GX8978@holomorphy.com>
Message-ID: <87wugoct0f.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

William Lee Irwin III <wli@holomorphy.com> writes:

> On Fri, May 16, 2003 at 01:26:20PM +0200, Alexander Hoogerhuis wrote:
> >>> This one goes in -mm5 as well, machine runs fine for a while in X, but
> >>> trying to switch to a vty send the machine into the tall weeds...
> 
> On Fri, May 16, 2003 at 11:08:48AM -0700, William Lee Irwin III wrote:
> >> Could you run with the radeon driver non-modular and kernel debugging
> >> on? Then when it oopses could you use addr2line(1) to resolve this to
> >> a line number?
> >> I'm at something of a loss with respect to dealing with DRM in general.
> 
> On Fri, May 16, 2003 at 07:56:38PM +0100, Dave Jones wrote:
> > Not that I'm pointing fingers, but it could be that
> > reslabify-pgds-and-pmds.patch again  ? Maybe it's still not quite right?
> > Might be worth backing out and retesting, just to rule it out.
> 
> Yes, if he could try that too it would help. I got a private reply
> saying he'd be out of the picture for over 24 hours. I'm looking for
> someone with a radeon to fill in the gap until then.
> 

I'm back in the picture now, the machine is chugging along, churning
out a new kernel. I'll get the details out in a few hours :)

> 
> -- wli

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+x4McCQ1pa+gRoggRAl0SAJ49l27s2cdi7pNNCE8xI6MtC2wrdQCgxotU
Nlqa0EFTAAZ/XoSi/HHi8Ng=
=XpPy
-----END PGP SIGNATURE-----
