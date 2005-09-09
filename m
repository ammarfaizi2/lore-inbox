Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbVIIJYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbVIIJYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVIIJYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:24:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:53181 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965129AbVIIJYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:24:04 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Date: Fri, 9 Sep 2005 11:23:58 +0200
User-Agent: KMail/1.8
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <200509091054.11932.ak@suse.de> <43216EFB020000780002489B@emea1-mh.id2.novell.com>
In-Reply-To: <43216EFB020000780002489B@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091123.59205.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 11:16, Jan Beulich wrote:
> >>> Andi Kleen <ak@suse.de> 09.09.05 10:54:11 >>>
> >
> >On Thursday 08 September 2005 18:04, Jan Beulich wrote:
> >> (Note: Patch also attached because the inline version is certain to
>
> get
>
> >> line wrapped.)
> >>
> >> Allow building the x86-64 kernels with frame pointers if so needed.
> >
> >This doesn't work because you would need to pass
>
> -fno-omit-frame-pointer
>
> >somewhere.
>
> So is done in the top-level makefile.

Indeed. Someone must have fixed it.  But why would anyone want frame pointers
on x86-64?

-Andi
