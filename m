Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVDZFnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVDZFnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVDZFnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:43:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36332 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261328AbVDZFnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:43:10 -0400
Date: Tue, 26 Apr 2005 13:46:49 +0800
From: David Teigland <teigland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Wim Coekaerts <wim.coekaerts@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
Message-ID: <20050426054649.GB12096@redhat.com>
References: <20050425151136.GA6826@redhat.com> <20050425203952.GE25002@ca-server1.us.oracle.com> <20050425141953.51a71862.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425141953.51a71862.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 02:19:53PM -0700, Andrew Morton wrote:
> In an ideal world, the various clustering groups would haggle this thing
> into shape, come to a consensus patch series which they all can use and I
> would never need to look at the code from a decision-making POV.

It appears that the different clustering groups are all involved.  As I
said, we're committed to making this useful for everyone.  Our approach
from the start has been to copy the "standard" dlm api available on other
operating systems (in particular VMS); there's never been a tie to one
application.  We're also trying to make the behaviour configurable at
points where there are useful differences in the dlm's people are
accustomed to.

Other groups will obviously not be able to adopt this dlm immediately, but
the goal is for them to be _able_ to do so eventually -- if they want and
when time permits.  If anyone is _unable_ to use this dlm for some
technical reason, we'd definately like to know about that now so it can be
fixed.

Thanks,
Dave

