Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbUCRWCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUCRWCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:02:42 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:43536 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263210AbUCRWCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:02:30 -0500
Date: Thu, 18 Mar 2004 22:42:30 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Mark <mark@harddata.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon CPU detection..
Message-ID: <20040318214230.GE14537@alpha.home.local>
References: <4059FCB9.4070204@lbl.gov> <200403181352.34737.mark@harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403181352.34737.mark@harddata.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 01:52:34PM -0700, Mark wrote:
> On March 18, 2004 12:47 pm, Thomas Davis <tadavis@lbl.gov> wrote:
> >
> > Is this a bad CPU, or a kernel bug?
> 
> AFAIK this information comes from the Bios. Some bioses don't verify that the 
> second CPU as being an MP. It's been known for some time. Some people were 
> using this to run 1 MP and 1 XP to save money on processors. However if you 
> were to update your bios, it might start checking both for being MPs. 
> Original bioses didn't even check for the first processor at one time but AMD 
> complained and the bioses were modified.

I can confirm this. I have two XP 1800 on my A7M266D, and the earlier bioses
reported different CPUs. Now after the bios upgrade, it simply reports that
they both are real MPs ! I even removed the fans once to be sure !

Cheers,
Willy

