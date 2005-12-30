Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbVL3RvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVL3RvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 12:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbVL3RvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 12:51:23 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:4364 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750866AbVL3RvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 12:51:22 -0500
Date: Fri, 30 Dec 2005 18:48:17 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       alan@redhat.com
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Message-ID: <20051230174817.GW15993@alpha.home.local>
References: <20051230074401.GA7501@ip68-225-251-162.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230074401.GA7501@ip68-225-251-162.oc.oc.cox.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 11:44:01PM -0800, Barry K. Nathan wrote:
> This patch adds strict VM overcommit accounting to the mainline 2.4
> kernel, thus allowing overcommit to be truly disabled. This feature
> has been in 2.4-ac, Red Hat Enterprise Linux 3 (RHEL 3) vendor kernels,
> and 2.6 for a long while.

Many thanks, I'm impatient to try it ! I tried to backport it in the
past but miserably failed as I don't understand those areas well. I'm
interested in checking that a buggy service cannot eat all the RAM an
bring the machine to death.

Cheers,
Willy

