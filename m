Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUH1KiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUH1KiA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUH1KiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:38:00 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:34791 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267401AbUH1Khn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 06:37:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: data loss in 2.6.9-rc1-mm1
Date: Sat, 28 Aug 2004 12:47:57 +0200
User-Agent: KMail/1.5
Cc: linuxram@us.ibm.com, hugh@veritas.com, dice@mfa.kfki.hu,
       vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain> <20040828024504.70407b43.akpm@osdl.org> <41305BFF.6040209@yahoo.com.au>
In-Reply-To: <41305BFF.6040209@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408281247.57448.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 of August 2004 12:18, Nick Piggin wrote:
> Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >>Well, guys, to make it 100% clear: if I apply the Nick's patch to the
> >> 2.6.9-rc1-mm1 tree, it will fix the data loss issue.  Is that right?
> >
> > Should do.
>
> It passes test cases that would previously fail here, so consider it
> lightly tested. Note that the patch is on top of 2.6.9-rc1 though,
> it becomes slightly deranged when applying straight onto mm. So don't
> do that.
>
> ..
>
> >  Or revert
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2
> >.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one-cleanup.patch
> >
> > and then
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2
> >.6.9-rc1-mm1/broken-out/re-fix-pagecache-reading-off-by-one.patch
>
> Once you have these backed out mine should apply fine, but it only closes
> some performance (not correctness) corner cases that the above patches
> attempted to.

OK.  Thanks a lot,

RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
