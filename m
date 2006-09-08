Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751932AbWIHAOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbWIHAOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 20:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWIHAOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 20:14:30 -0400
Received: from relay01.pair.com ([209.68.5.15]:14603 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1751932AbWIHAO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 20:14:28 -0400
X-pair-Authenticated: 71.197.50.189
Date: Thu, 7 Sep 2006 19:04:36 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: David Abrahams <dave@boost-consulting.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: prepatching errors
In-Reply-To: <87k64fz0nj.fsf@pereiro.peloton>
Message-ID: <Pine.LNX.4.64.0609071903400.32079@turbotaz.ourhouse>
References: <87k64fz0nj.fsf@pereiro.peloton>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, David Abrahams wrote:

>
> Hi,
>
> I'm trying to apply the 2.6.18-rc6 prepatch (from
> http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.18-rc6.bz2)
> to the 2.6.17.11 sources (from
> http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.11.tar.bz2) using

David,
 	The -rc series patches should be applied to the last mainline (not 
-stable) release. In your case, you want to patch 2.6.17.

Thanks,
Chase

>  patch -p1 < ~/patch-2.6.18-rc6
>
> and I'm seeing various error messages, e.g.:
>
>  patching file Makefile
>  Hunk #1 FAILED at 1.
>  1 out of 39 hunks FAILED -- saving rejects to file Makefile.rej
>
>  ...
>
>  patching file arch/um/kernel/time_kern.c
>  Reversed (or previously applied) patch detected!  Assume -R? [n]
>  Apply anyway? [n]
>  Skipping patch.
>  1 out of 1 hunk ignored -- saving rejects to file arch/um/kernel/time_kern.c.rej
>
> Am I doing something wrong?  Is this normal?
>
> I'm downloading the 2.6.17.11 tarball again just in case I've confused
> something, but I've been untaring the raw material from a file I have
> called linux-2.6.17.11.tar.bz2, so it seems unlikely.
>
> Any advice appreciated!
>
> Thanks,
>
>
