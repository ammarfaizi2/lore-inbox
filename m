Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264669AbUFPXy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264669AbUFPXy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 19:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbUFPXy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 19:54:58 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:62111 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S264669AbUFPXy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 19:54:56 -0400
Organization: 
Date: Thu, 17 Jun 2004 02:54:41 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
In-Reply-To: <40D044BA.4080009@kolivas.org>
Message-ID: <Pine.GSO.4.58.0406170250430.8103@thanatos.csd.uoc.gr>
References: <1087333441.40cf6441277b5@vds.kolivas.org> <40D04439.5080100@gmx.de>
 <40D044BA.4080009@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UT2004 works just fine here on a 2.6.7-rc3-mm2 with s6.E!
By the way great work Con!

P.S.
There is some problem with the patch for the mm2.
All hunks succeeded but somehow there was a compilation error in kernel/sched.c.
After commenting out the following line I was able to compile the kernel:
line 118:
/*prio_array_t *active, *expired, arrays[2];*/

	Panagiotis Papadakos

On Wed, 16 Jun 2004, Con Kolivas wrote:

> Prakash K. Cheemplavam wrote:
> > Con Kolivas wrote:
> >
> >> Here is an updated version of the staircase scheduler. I've been
> >> trying to hold
> >> off for 2.6.7 final but this has not been announced yet. Here is a
> >> brief update
> >> summary.
> >
> >
> > Hi, does this resolve the issue with ut2004? (Or is another setting for
> > it needed?) I haven't tried myself, but others reported that setting
> > interactive to 0 didn't help, nor giving ut2004 more priority via (re)nice.
>
> Good question. I don't own UT2004 so I was hoping a tester might
> enlighten me.
>
> Con
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
