Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVKAIlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVKAIlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVKAIlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:41:05 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54158
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964974AbVKAIlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:41:02 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 1/20] inflate: lindent and manual formatting changes
Date: Tue, 1 Nov 2005 01:50:21 -0600
User-Agent: KMail/1.8
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <2.196662837@selenic.com> <17254.46523.698248.169639@cargo.ozlabs.ibm.com> <20051101013955.GG4367@waste.org>
In-Reply-To: <20051101013955.GG4367@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010150.21851.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 19:39, Matt Mackall wrote:
> On Tue, Nov 01, 2005 at 11:24:27AM +1100, Paul Mackerras wrote:
> > Matt,
> >
> > My concern about this series of patches is that it will make it harder
> > to keep the kernel zlib in sync with the upstream zlib.
>
> This code is very long out of sync with the existing upstream zlib in
> terms of coding style and content, so I doubt my changes will make
> much difference from that perspective.
>
> As one of my eventual goals is to get us down to exactly one copy of
> this in the kernel, I think it's a step forward. This set of patches
> goes a long way towards that goal by making inflate support just a
> couple lines for most of the kernel uses.
>
> > Are you signing up to track the upstream zlib and apply any changes
> > made there to the kernel version, for the forseeable future?
>
> I will fix any security-relevant bugs, provided other folks don't beat
> me to them.

Something that may help:

The zlib developers take down old versions because they don't want people 
using out of date stuff with known security bugs, but I asked the zlib 
developers nicely if they could put the history up anyway, because busybox 
also contains its own somewhat-shrunk fork of the gzip code, and we want to 
make sure we don't miss any security fixes.  They were nice enough to 
populate "http://zlib.net/fossils/", which you might find useful too.

Rob

(Not that I've had time to go through and see what if any security fixes 
relevant to busybox there might be in there yet.  If you find anything 
interesting, could you let me know? :)
