Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbSLRMxT>; Wed, 18 Dec 2002 07:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbSLRMxS>; Wed, 18 Dec 2002 07:53:18 -0500
Received: from users.linvision.com ([62.58.92.114]:37775 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S267242AbSLRMxR>; Wed, 18 Dec 2002 07:53:17 -0500
Date: Wed, 18 Dec 2002 14:00:59 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Ulrich Drepper <drepper@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218140059.B15645@bitwizard.nl>
References: <3DFF7951.6020309@transmeta.com> <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 11:37:04AM -0800, Linus Torvalds wrote:
> How much do you think gettimeofday() really matters on a desktop? Sure, X
> apps do gettimeofday() calls, but they do a whole lot more of _other_
> calls, and gettimeofday() is really far far down in the noise for them.
> The people who really call for gettimeofday() as a performance thing seem
> to be database people who want it as a timestamp. But those are the same
> people who also want NUMA machines which don't necessarily have
> synchronized clocks.

Once the kernel provides the right infrastructure, doing it may become
so easy that it can be tried and implemented and benchmarked with so
little effort that it would simply stick.

			Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
