Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285031AbRLUTPm>; Fri, 21 Dec 2001 14:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285014AbRLUTPc>; Fri, 21 Dec 2001 14:15:32 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:42509 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S285007AbRLUTP2>;
	Fri, 21 Dec 2001 14:15:28 -0500
Date: Tue, 18 Dec 2001 00:46:27 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mempool-2.5.1-D2
Message-ID: <20011218004626.E37@toy.ucw.cz>
In-Reply-To: <20011214172728.B26535@redhat.com> <Pine.LNX.4.33.0112150653310.22818-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0112150653310.22818-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Dec 15, 2001 at 07:41:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  - mempool_alloc(), if called from a process context, never fails. This
>    simplifies lowlevel IO code (which often must not fail) visibly.

Really? I do not see how you can guarantee this on machine with finite
ammount of memory.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

