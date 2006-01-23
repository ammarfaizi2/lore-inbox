Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWAWSEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWAWSEF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWAWSEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:04:04 -0500
Received: from [212.76.86.174] ([212.76.86.174]:3343 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S964856AbWAWSED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:04:03 -0500
From: Al Boldi <a1426z@gawab.com>
To: Robin Holt <holt@sgi.com>
Subject: Re: [RFC] VM: I have a dream...
Date: Mon, 23 Jan 2006 21:03:06 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200601212108.41269.a1426z@gawab.com> <20060122123335.GB26683@lnx-holt.americas.sgi.com>
In-Reply-To: <20060122123335.GB26683@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601232103.07007.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
> On Sat, Jan 21, 2006 at 09:08:41PM +0300, Al Boldi wrote:
> >
> > Wouldn't it be nice to take advantage of todays 64bit archs and TB
> > drives, and run a more modern way of life w/o this memory/storage split
> > personality?
>
> Your simple world introduces a level of complexity to the kernel which
> is nearly unmanageable.  Basically, you are asking the system to intuit
> your desires.  The swap device/file scheme allows an administrator to
> control some aspects of their system while giving the kernel developer
> a reasonable number of variables to work with.  That, at least to me,
> does not sound schizophrenic, but rather very reasonable.
>
> Sorry for raining on your parade,

Thanks for your detailed response, it rather felt like a fresh breeze.

Really, I was more thinking about a step by step rather than an all or none 
approach.  Something that would involve tmpfs merged with swap mapped into 
linear address space limited by arch bits, and everything else connected as 
archive.

The idea here is to run inside swap instead of using it as an addon.
In effect running inside memory cached by physical RAM.

Wouldn't something like this at least represent a simple starting point?

Thanks!

--
Al

