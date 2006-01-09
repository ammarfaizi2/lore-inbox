Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWAIPR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWAIPR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWAIPR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:17:29 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:6553 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932374AbWAIPR2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:17:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SU3tDqqBV9KE3KRjPAlkr7tDEgq9ow032tn7qzKbE62fMfSSMxp3vB/6CGN3fugvlOQxl7eFmyGB6Llq1/Y2O4hp6OZrBrM6+E5pM3LxrgjxGXjLSWon/EP8uJjoJHadQkV0ZvyPq8hG+MJPbm+620/L7yrFwrKpA3R8a8JT3Rw=
Message-ID: <84144f020601090717pec211a3hc2125fe90196dbef@mail.gmail.com>
Date: Mon, 9 Jan 2006 17:17:24 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Subject: Re: [OT?] Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Cc: Lee Revell <rlrevell@joe-job.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601091751.27405.yarick@it-territory.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	 <200601091403.46304.yarick@it-territory.ru>
	 <1136814862.9957.5.camel@mindpipe>
	 <200601091751.27405.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/9/06, Yaroslav Rastrigin <yarick@it-territory.ru> wrote:
> Been there, done that. Bugreport about malfunctioning (due to ACPI)
> 3c556 in IBM ThinkPad T20 was looked at once in a few months
> without any progress, and I've finally lost track of it after changing
> hardware. In more than a year this problem wasn't solved, so I'm
> assuming bugreports aren't so effective.

Unfortunately bug reports are sometimes lost in the noise. How many
times did you resend the bug report? Did you report all the required
information? Were you able to isolate the failing subsystem? Was there
a working kernel version? Did you try to isolate the changeset that
introduced the bug? Sometimes you have to complain many times and do a
bit of investigative work yourself. There are plenty of bug reports on
LKML which are being ignored because the original reported fails to
follow up on the problem.

On 1/9/06, Yaroslav Rastrigin <yarick@it-territory.ru> wrote:
> 2200BG ping and packet loss problem was reported in ipw2200-devel
> mailing list recently (by another user), and the only answer was
> "Switch to version 1.0.0" (which is tooo old and missing needed features
> and bugfixes, so recommentation was unacceptable). So I'm assuming
> addressing developers directly is not too effective either.

IPW2200 hardware documentation is closed which narrows down the amount
of people who can help you out, sorry. Perhaps you could complain to
your vendor?

                                    Pekka
