Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWAAObB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWAAObB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 09:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWAAObB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 09:31:01 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:40170 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932215AbWAAObA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 09:31:00 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Date: Sun, 1 Jan 2006 14:31:21 +0000
User-Agent: KMail/1.9
Cc: Bradley Reed <bradreed1@gmail.com>, linux-kernel@vger.kernel.org
References: <20051231202933.4f48acab@galactus.example.org> <1136106861.17830.6.camel@laptopd505.fenrus.org>
In-Reply-To: <1136106861.17830.6.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601011431.21303.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 January 2006 09:14, Arjan van de Ven wrote:
> On Sat, 2005-12-31 at 20:29 +0200, Bradley Reed wrote:
> > I have tried MPlayer versions 1.0pre6, 1.0pre7, and cvs from today and
> > they all work fine under 2.6.14 and 2.6.14-rt21/22.
> >
> > I booted into 2.6.15-rc7-rt1 and the same MPlayer binaries segfault on
> > every video I try and play. Yes, I have nvidia modules loaded, so won't
> > get much help, but thought someone might like to know.
>
> you know, you could have done a little bit more effort and reproduced
> this without the binary crud... it's not that hard you know and it shows
> that you actually care about the problem enough that you want to make it
> worthwhile for people to look into it.

REPORTING-BUGS should probably be fixed to make the points you repeatedly have 
to make. I agree 100% that people should not be reporting easily reproducible 
bugs with proprietary drivers loaded; what's a reboot to them?

Let's add something to REPORTING-BUGS about tainted kernels and/or proprietary 
drivers. A quick grep of this file from 2.6.15-rc6 gives me no hits for 
"proprietary", "tainted" or "binary".

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
