Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030548AbWJ3Pr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbWJ3Pr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030545AbWJ3Pr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:47:59 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:27810 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030547AbWJ3Pr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:47:58 -0500
Subject: Re: loading EHCI_HCD slows down IDE disk performance by 50%
From: Lee Revell <rlrevell@joe-job.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5a4c581d0610291152r7f538188m4ce52fba1f5f4683@mail.gmail.com>
References: <5a4c581d0610291013w40c1b0e6g408051a79534956a@mail.gmail.com>
	 <1162146560.14733.65.camel@mindpipe>
	 <5a4c581d0610291152r7f538188m4ce52fba1f5f4683@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 10:48:10 -0500
Message-Id: <1162223291.14733.119.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-29 at 20:52 +0100, Alessandro Suardi wrote:
> On 10/29/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Sun, 2006-10-29 at 19:13 +0100, Alessandro Suardi wrote:
> > > Any hints/tips about what to try with this issue will be
> > >  of course very welcome.
> >
> > git bisect
> 
> As I clarified to Lee in private email, this method doesn't
>  seem to apply in this situation, as the problem appeared
>  when I selected CONFIG_EHCI_HCD in my build due to the
>  purchase of the USB2.0 disk, back in the 2.6.16-rc cycle;
>  so if the combination of high performance IDE + EHCI_HCD
>  ever existed, it must be earlier than 2.6.16-rc5-git8.
> 
> Lacking any input I'll try to find out more in the next week
>  by starting out at 2.6.10 and eventually earlier.

Maybe you could close the Bugzilla ticket you posted, as most of the
comments relate to HAL and polling for media changes which you seem to
be saying have nothing to do with this bug?

Lee

