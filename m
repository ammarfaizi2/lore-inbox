Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVEDSB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVEDSB2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVEDR76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:59:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:61079 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261182AbVEDR7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:59:13 -0400
Date: Wed, 4 May 2005 23:28:07 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment policy
Message-ID: <20050504175807.GA5445@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com> <200505041716.j44HGPbV016851@turing-police.cc.vt.edu> <1115227516.22718.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115227516.22718.4.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 10:25:16AM -0700, Dave Hansen wrote:
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

I don't like it, but that is only because your mailer sends
them as test/x-patch and my mailer cannot quote the patch in reply :)

Thanks
Dipankar
