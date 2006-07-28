Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWG1X4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWG1X4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWG1X4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:56:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43437 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751331AbWG1X4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:56:43 -0400
Date: Fri, 28 Jul 2006 19:55:34 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Nathan Scott <nathans@sgi.com>, stable@kernel.org,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.17.[1-6] XFS Filesystem Corruption, Where is 2.6.17.7?
Message-ID: <20060728235534.GE3217@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Nathan Scott <nathans@sgi.com>, stable@kernel.org,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0607241224010.10896@p34.internal.lan> <20060725084624.C2090627@wobbly.melbourne.sgi.com> <20060725210716.GC4807@merlin.emma.line.org> <20060725210919.GD4807@merlin.emma.line.org> <20060728232654.GB2140@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728232654.GB2140@kroah.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 04:26:54PM -0700, Greg Kroah-Hartman wrote:

 > > OK, 2.6.17.7 is out, but still - is this suggestion worthwhile
 > > considering for future -stable release engineering or just crap?
 > 
 > .7 took a bit longer than expected, due to some security bugs that
 > needed to be added to the queue, combined with the fact that both Chris
 > and I were busy with OLS stuff.  Normally we both aren't travelling at
 > the same time, but right then, we were, so we couldn't respond as
 > quickly as it seems some people felt we should have.
 > 
 > Sorry about this, we'll try to do better next time.

The flipside to this is that those patches had been posted for around a
week before you released .7, and *no-one* caught this problem until
after the release.

The burden of testing shouldn't solely be on the -stable team.
Perhaps a -pre release at the time of review would be a good idea.
Just a roll-up of the proposed patches, to save testers having
to save and apply 30 patches seperately ?

		Dave

-- 
http://www.codemonkey.org.uk
