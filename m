Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319216AbSHUVOs>; Wed, 21 Aug 2002 17:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319217AbSHUVOs>; Wed, 21 Aug 2002 17:14:48 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:51472 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S319216AbSHUVOr>; Wed, 21 Aug 2002 17:14:47 -0400
Date: Wed, 21 Aug 2002 14:16:11 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: James Bourne <jbourne@mtroyal.ab.ca>
cc: Hugh Dickins <hugh@veritas.com>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Hyperthreading
In-Reply-To: <Pine.LNX.4.44.0208211242440.10117-100000@skuld.mtroyal.ab.ca>
Message-ID: <Pine.LNX.4.44.0208211414190.6621-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, James Bourne wrote:

> On Wed, 21 Aug 2002, Hugh Dickins wrote:
> 
> > You do need CONFIG_SMP and a processor capable of HyperThreading,
> > i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> > just appropriate to that processor in other ways.
> 
> I was under the impression that the only CPU capable of hyperthreading was
> the P4 Xeon.  Is this not correct?  I don't know of any other CPUs that
> have the ht feature.

This is currently correct, although I believe Intel has plans to release a 
Hyperthreading-capable version of its desktop P4. 

> Also, looking at setup.c it's hard to determine if CONFIG_SMP is
> actually required, but it doesn't look like it...

Of course it's required. How are you to take advantage of a "second CPU" 
if your scheduler only works on a uniprocessor machine?

-- 
 Kelsey Hudson                                       khudson@compendium.us
 Software Engineer/UNIX Systems Administrator
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

