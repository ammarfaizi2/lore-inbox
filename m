Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVKMJbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVKMJbb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 04:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVKMJbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 04:31:31 -0500
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:51098 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932166AbVKMJbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 04:31:31 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] plugsched - update Kconfig-1
Date: Sun, 13 Nov 2005 20:30:36 +1100
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <434F01EA.6060709@bigpond.net.au> <200511131637.40704.kernel@kolivas.org> <4377031F.5000902@bigpond.net.au>
In-Reply-To: <4377031F.5000902@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511132030.36777.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Nov 2005 20:10, Peter Williams wrote:
> Con Kolivas wrote:
> > On Sun, 13 Nov 2005 16:22, Peter Williams wrote:
> >>Con Kolivas wrote:
> >>>On Sun, 13 Nov 2005 12:34, Peter Williams wrote:
> >>>>1. Make the ability to select which schedulers are built in independent
> >>>>of EMBEDDED.
> >>>>2. Only offer builtin schedulers as choice for the default scheduler.
> >>>>3. Only build in ingosched if PLUGSCHED is not configured.
> >>>
> >>>I disagree with 3. Surely people might want to build in only one
> >>>scheduler that is not ingosched without other choices.
> >>
> >>Yes, and they would be able to do that by selecting PLUGSCHED and then
> >>selecting only the scheduler that they want.  But this then leads to the
> >>observation that PLUGSCHED is probably makes things unnecessarily
> >>complex and all that is required is a means to select the schedulers to
> >>be built in and a choice of default (much like for the IO schedulers)?
> >
> > Indeed it may be better to remove the "plugsched" option entirely. Once
> > patched in it's not like you are building the kernel without the
> > plugsched infrastructure. Provided each extra scheduler does not increase
> > the kernel size too much (and a test build with/without all schedulers
> > should tell you that), it may be best to just have the scheduler choice
> > in the top menu and only expose the "schedulers to build in" under
> > embedded.
>
> I can't see why this should be restricted to embedded systems?

It's just convention that size options go in there; it's not really just for 
embedded systems.

Cheers,
Con
