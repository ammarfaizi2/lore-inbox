Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWBKWNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWBKWNN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWBKWNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:13:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41923 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750743AbWBKWNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:13:13 -0500
Date: Sat, 11 Feb 2006 17:13:09 -0500
From: Dave Jones <davej@redhat.com>
To: Nico Golde <nico@ngolde.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting cpu frequency
Message-ID: <20060211221309.GE8337@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nico Golde <nico@ngolde.de>, linux-kernel@vger.kernel.org
References: <20060211204733.GA7813@ngolde.de> <20060211213748.GD8337@redhat.com> <20060211214207.GB19045@ngolde.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211214207.GB19045@ngolde.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 10:42:07PM +0100, Nico Golde wrote:
 > Hallo Dave,
 > 
 > * Dave Jones <davej@redhat.com> [2006-02-11 22:38]:
 > > On Sat, Feb 11, 2006 at 09:47:34PM +0100, Nico Golde wrote:
 > >  > Hi,
 > >  > at the moment I try to get the current cpu frequency
 > >  > P.S. Please CC me, I am not subsribed, thanks
 > > 
 > > Are you trying to do this from a userspace program ?
 > > If so, this isn't going to work.
 > 
 > Yes I am.

Read it from sysfs or /proc/cpuinfo.
But, why does your app care ?
If it's to set up some sort of timing loop, it's going to
fail miserably.

		Dave
		
