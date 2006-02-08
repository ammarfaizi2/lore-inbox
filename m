Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWBHVV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWBHVV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWBHVV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:21:57 -0500
Received: from cantor2.suse.de ([195.135.220.15]:59870 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965000AbWBHVV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:21:56 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: Terminate process that fails on a constrained allocation
Date: Wed, 8 Feb 2006 22:21:35 +0100
User-Agent: KMail/1.8.2
Cc: clameter@engr.sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602081004060.2648@schroedinger.engr.sgi.com> <200602082201.12371.ak@suse.de> <20060208130351.fc1c759c.pj@sgi.com>
In-Reply-To: <20060208130351.fc1c759c.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602082221.35671.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 22:03, Paul Jackson wrote:
> > I don't think you really want to open a  full scale "is the oom killer needed"
> > thread. Check the archives - there have been some going on for months.
> > 
> > But I think we can agree that together with mbind the oom killer is pretty
> > useless, can't we?
> 
> Excellent points.
> 
> I approve this patch.

I think it should be put into 2.6.16. Andrew?

I had the small objection about adding static noinline, but it's really not important
and the patch can be used as it.

-Andi


