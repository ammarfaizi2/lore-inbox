Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWCWSmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWCWSmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 13:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWCWSmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 13:42:16 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:3736 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932546AbWCWSmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 13:42:15 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: swap prefetching merge plans
Date: Thu, 23 Mar 2006 19:40:56 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org>
In-Reply-To: <200603231804.36334.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231940.56931.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 23 March 2006 08:04, Con Kolivas wrote:
> On Thu, 23 Mar 2006 03:53 pm, Andrew Morton wrote:
> > A look at the -mm lineup for 2.6.17:
> 
> > mm-implement-swap-prefetching.patch
> > mm-implement-swap-prefetching-fix.patch
> > mm-implement-swap-prefetching-tweaks.patch
> 
> >   Still don't have a compelling argument for this, IMO.
> 
> For those users who feel they do have a compelling argument for it, please 
> speak now or I'll end up maintaining this in -ck only forever.  I've come to 
> depend on it with my workloads now so I'm never dropping it. There's no point 
> me explaining how it is useful yet again, though, because I just end up 
> looking like I'm handwaving. It seems a shame for it not to be available to 
> all linux users.

AFAICT, it may help get the system more responsive after resume from suspend
to disk.  However, I'd like to get some hard data to support this, but I have
a little time to test it myself now.  Also I haven't thought about the
methodology yet.

If anyone can help with that, please go for it.

Greetings,
Rafael
