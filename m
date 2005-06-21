Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVFUNKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVFUNKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVFUNKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:10:39 -0400
Received: from [203.171.93.254] ([203.171.93.254]:9641 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261383AbVFUNHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:07:36 -0400
Subject: Re: -mm -> 2.6.13 merge status (Suspend-to-disk)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
References: <20050620235458.5b437274.akpm@osdl.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1119359295.10186.1150.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 21 Jun 2005 23:08:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(Marcelo: Copied for issue at the bottom).

On Tue, 2005-06-21 at 16:54, Andrew Morton wrote:
> CPU hotplug for x86 and x86_64
> 
>     Not really useful on current hardware, but these provide
>     infrastructure which some power management patches need, and it seems
>     sensible to make the reference architecture support hotplug.  Will merge.

Yay. I'm not going to use it yet, but know Pavel wants it for the next
one.

> swsusp-on-SMP
> 
>     Will merge.
> 
> kexec and kdump
> 
>     I guess we should merge these.
> 
>     I'm still concerned that the various device shutdown problems will
>     mean that the success rate for crashing kernels is not high enough for
>     kdump to be considered a success.  In which case in six months time we'll
>     hear rumours about vendors shipping wholly different crashdump
>     implementations, which would be quite bad.
> 
>     But I think this has gone as far as it can go in -mm, so it's a bit of
>     a punt.

No potential clashes with suspend code, I assume?

> execute-in-place
> 
>     Will merge.  Have the embedded guys commented on the usefulness of
>     this for execute-out-of-ROM?

Switch roles for a mo and put my Cyclades hat on. Probably not useful to
us at the moment, at least in the case of the products I work on.
Marcelo?

Regards,

Nigel

