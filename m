Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWEZEdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWEZEdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWEZEdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:33:06 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:28942 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030408AbWEZEdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:33:05 -0400
Date: Fri, 26 May 2006 06:23:44 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>, Jeff Garzik <jeff@garzik.org>
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060526042343.GV11191@w.ods.org>
References: <e55715+usls@eGroups.com> <447622EA.90704@garzik.org> <20060525213952.GT13513@lug-owl.de> <20060525214413.GE4328@redhat.com> <20060525225222.GA14552@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525225222.GA14552@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 26, 2006 at 12:52:22AM +0200, Olivier Galibert wrote:
> On Thu, May 25, 2006 at 05:44:13PM -0400, Dave Jones wrote:
> > Following /lib/modules/`uname -r`/build is the only way this can work.
> > (And that should be true on any distro)
> 
> On one side it's a reasonably nice way, on the other it makes it hard
> to build modules for a different kernel than the running one.  I have
> a uname version in a corner that allows overriding the -r return with
> an environment variable just for that reason, I should probably send
> the path upstream.

I agree with Olivier here.

The trick above should only be a hint to propose to the user what has
been found. If he doesn't know, it's certainly OK. Otherwise, he must
have the ability to use anything else (often needed for packaging or
for cross-building).

Regards,
Willy

