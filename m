Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965301AbWFAVE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbWFAVE2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbWFAVE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:04:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57555 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965301AbWFAVE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:04:27 -0400
Date: Thu, 1 Jun 2006 23:04:04 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Martin Bligh <mbligh@mbligh.org>
cc: "Martin J. Bligh" <mbligh@google.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <447F1BE4.5040705@mbligh.org>
Message-ID: <Pine.LNX.4.64.0606012200260.32445@scrub.home>
References: <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org>
 <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org>
 <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org>
 <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com>
 <20060531223243.GC5269@elte.hu> <447E1A7B.2000200@google.com>
 <20060531225013.GA7125@elte.hu> <Pine.LNX.4.64.0606011222230.17704@scrub.home>
 <447EFE86.7020501@google.com> <Pine.LNX.4.64.0606011659030.32445@scrub.home>
 <447F084C.9070201@google.com> <Pine.LNX.4.64.0606011742500.32445@scrub.home>
 <447F1BE4.5040705@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Jun 2006, Martin Bligh wrote:

> So the point is to enable the performance-affecting debug options by
> default, but provide one clear hook to turn them all off, with a name
> that's consistent over time, so we can do it in an automated fashion.

The latter is what Ingo's patch doesn't really do and the first should 
stay in -mm. If we talk about an -mm only patch we can relax the rules a 
little, my NACK was for mainline inclusion. The problem is that my request 
for a -mm only patch and other changes has been met with utter ignorance 
so far by Ingo.

> To me that means having clear name so people know which option to hook
> stuff under, and preferably not hiding stuff behind extra config options
> to make them harder to find. Maybe I've missed the point of what you
> were trying to do, but it seemed to not meet that.

Well, if you don't want to enable a number of options, it's still better 
to hide them completely. There are number of options by reorganizing the 
debug menu a little, it only depends if we're talking here are about a -mm 
only crutch or something which might be useful to more than a handful of 
people. A few extra config options are not really a problem as long as 
they are logically grouped together (instead of having to enable random 
options all over the place).

bye, Roman
