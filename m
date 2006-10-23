Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWJWOOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWJWOOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 10:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWJWOOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 10:14:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:34236 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751623AbWJWOOc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 10:14:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PAE and PSE ??
Date: Mon, 23 Oct 2006 16:14:05 +0200
User-Agent: KMail/1.9.1
Cc: Sandeep Kumar <sandeepksinha@gmail.com>, linux-kernel@vger.kernel.org
References: <37d33d830610212329o420e0ee4i75e6bddfcf2fb772@mail.gmail.com> <200610231213.47232.rjw@sisk.pl> <453CCD5E.6060303@zytor.com>
In-Reply-To: <453CCD5E.6060303@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610231614.05716.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 23 October 2006 16:10, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
> > 
> > Well, "AMD64 Architecture Programmer’s Manual" says the following:
> > 
> > The choice of 2 Mbyte or 4 Mbyte as the large physical-page size
> > depends on the value of CR4.PSE and CR4.PAE, as follows:
> > - If physical-address extensions are enabled (CR4.PAE=1), the
> >    large physical-page size is 2 Mbytes, regardless of the value
> >    of CR4.PSE.
> > - If physical-address extensions are disabled (CR4.PAE=0)
> >    and CR4.PSE=1, the large physical-page size is 4 Mbytes.
> > - If both CR4.PAE=0 and CR4.PSE=0, the only available page
> >    size is 4 Kbytes.
> > 
> 
> That would be a retroactive redef on the part of AMD; it probably makes 
> sense for x86-64 if someone thinks that is may drop support for 4 MB 
> pages at some point in the distant future.  Still, I'm not sure Intel 
> would agree with the definition as stated, although I haven't looked in 
> the docs.
> 
> This is all extremely theoretical, since there has never been a chip 
> with PAE=1 and PSE=0, and I wouldn't expect one to appear any time soon.

Agreed.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
