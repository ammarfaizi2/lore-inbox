Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129323AbRCEP0a>; Mon, 5 Mar 2001 10:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129329AbRCEP0K>; Mon, 5 Mar 2001 10:26:10 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:6901 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S129339AbRCEPZ7>; Mon, 5 Mar 2001 10:25:59 -0500
Date: Mon, 5 Mar 2001 11:36:59 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl,
        fluffy@snurgle.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <m3n1b0h9t3.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0103051135480.5591-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Mar 2001, Christoph Rohland wrote:

> > We've also seen (anecdotal evidence here) cases where a kernel
> > panics, which we believe may have to do with having 0 < swap < 2x
> > RAM.  We're investigating further.
> 
> That would be a kernel bug which should be fixed. The kernel should
> handle oom/oos.

There was a bug which made the OOM-killer not work for some
workloads. It should be fixed in the latest -ac kernels...

If in doubt, please test ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

