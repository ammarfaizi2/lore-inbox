Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWEITQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWEITQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWEITQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:16:06 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53633 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1750814AbWEITQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:16:05 -0400
Date: Tue, 9 May 2006 12:18:28 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, torvalds@osdl.org,
       Nigel Cunningham <ncunningham@cyclades.com>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.16.14
Message-ID: <20060509191828.GL24291@moss.sous-sol.org>
References: <20060505003526.GW24291@moss.sous-sol.org> <200605051152.39693.ncunningham@cyclades.com> <20060505023353.GA24291@moss.sous-sol.org> <200605050347.51703.s0348365@sms.ed.ac.uk> <445F95DC.4050109@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445F95DC.4050109@tmr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bill Davidsen (davidsen@tmr.com) wrote:
> Alistair John Strachan wrote:
> >The only thing to be careful of is that -stable fixes (or complete 
> >reworks) get merged with mainline, so the trees don't go out of sync. So 
> >far this seems to have been OK.
> >
> As I recall these patches may or may not go into mainline. The next full 
> release may address the problem in a whole new way.

As a general rule, we do our best to keep in sync.  Typically they go
to mainline first.  A few security patches may bypass that and go in
parallel.  And, of course, anything that's since been redone in mainline
to the point that the patch is not relevant will only live in -stable.

thanks,
-chris
