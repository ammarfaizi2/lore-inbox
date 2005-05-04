Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVEDR7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVEDR7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVEDR5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:57:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:50871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261176AbVEDRzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:55:42 -0400
Date: Wed, 4 May 2005 10:55:35 -0700
From: Chris Wright <chrisw@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment policy
Message-ID: <20050504175535.GT23013@shell0.pdx.osdl.net>
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com> <200505041716.j44HGPbV016851@turing-police.cc.vt.edu> <1115227516.22718.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115227516.22718.4.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Hansen (haveblue@us.ibm.com) wrote:
> On Wed, 2005-05-04 at 13:16 -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 04 May 2005 10:01:56 PDT, Dave Hansen said:
> > 
> > > -6) No MIME, no links, no compression, no attachments.  Just plain text.
> > > +6) No MIME, no links, no compression.  Just plain text.
> > 
> > Logically buggy.  You can't have an attachment without the MIME markup that
> > *says* it's an attachment.  I think what you meant was "No Content-Type-Encoding":
> > i.e. 'none' is acceptable, but 'quoted-printable' (which causes all the
> > spurious =20 and =3D you sometimes see) and 'base64' (uuencode on steroids)
> > aren't....
> 
> Thanks for pointing out my flawed logic.  I wasn't quite sure what was
> MIME and what wasn't.  How about the attached patch, instead?

I agree that things are better.  But, ironically, this patch is a case
in point.  It's attached as text/x-patch and makes replying to and
commenting on patch inline more laborious.  Perhaps it should be clear,
text/plain tends to work (and is better than inline whitespace damaged
patches).  Andrew's "The Perfect Patch" has some text you could lift.

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

thanks,
-chris
