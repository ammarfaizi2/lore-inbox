Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWFOMUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWFOMUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWFOMUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:20:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:63978 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030302AbWFOMUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:20:42 -0400
Date: Thu, 15 Jun 2006 14:20:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] m68k: bogus constraints in signal.h
In-Reply-To: <20060615120336.GQ27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606151420140.23732@scrub.home>
References: <20060615111126.GJ27946@ftp.linux.org.uk>
 <Pine.LNX.4.64.0606151343200.17704@scrub.home> <20060615120336.GQ27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jun 2006, Al Viro wrote:

> On Thu, Jun 15, 2006 at 01:46:55PM +0200, Roman Zippel wrote:
> > Hi,
> > 
> > On Thu, 15 Jun 2006, Al Viro wrote:
> > 
> > > bfset and friends need "o", not "m" - they don't work with autodecrement
> > > memory arguments.  bitops.h had it fixed, signal.h hadn't...
> > 
> > I have a better version for this one pending, which I have queued for 
> > 2.6.18.
> 
> Could you post it?

http://marc.theaimsgroup.com/?l=linux-m68k-cvscommit&m=114954838727448&w=2

bye, Roman
