Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbRFAAAW>; Thu, 31 May 2001 20:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263289AbRFAAAM>; Thu, 31 May 2001 20:00:12 -0400
Received: from ladakh.smo.av.com ([209.73.174.140]:65035 "EHLO smo.av.com")
	by vger.kernel.org with ESMTP id <S263285AbRFAAAB>;
	Thu, 31 May 2001 20:00:01 -0400
Message-ID: <3B16DA37.206FF579@av.com>
Date: Thu, 31 May 2001 16:56:39 -0700
From: Christopher Zimmerman <zim@av.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Zimmerman <zim@av.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 VM
In-Reply-To: <3B16C9A8.7090402@digitalme.com> <3B16CCE9.64597F2E@av.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Zimmerman wrote:

> "Trever L. Adams" wrote:
>
> > In my opinion 2.4.x is NOT ready for primetime.  The VM has been getting
> > worse since 2.4.0, I believe.  Definitely since and including 2.4.3.  I
> > cannot even edit a few images in gimp where the entire working set used
> > to fit entirely in memory.  The system now locks in some loop (SAK still
> > works).
> >
> > FILE CACHING IS BROKEN.  I don't care who says what, by the time swap is
> > half filled, it is time to start throwing away simple caches.  Not wait
> > until there is no more memory free and then lock in an infinite loop.
> >
> > My system has 128 Meg of Swap and RAM.
> >
> > Trever Adams
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> I've found that with the latest kernel release (2.4.5) VM performance has
> been greatly improved.  kswapd and bdflush no longer use 200% of my cpu
> cycles when simply doing a dd bs=1024 count=8388608 if=/dev/zero
> of=test.file.  All of my test systems remain responsive with about 180% cpu
> available.  These systems are running software RAID and 3ware IDE raid with
> 2GB of memory and 4GB swap.  Have you tried 2.4.5?
>
> -zim
>
> Christopher Zimmerman
> AltaVista Company
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

