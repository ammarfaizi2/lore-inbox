Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUBTNqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUBTNp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:45:59 -0500
Received: from 31.Red-80-59-88.pooles.rima-tde.net ([80.59.88.31]:7863 "EHLO
	jabato.portsdebalears.com") by vger.kernel.org with ESMTP
	id S261206AbUBTNmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:42:23 -0500
Date: Fri, 20 Feb 2004 14:42:18 +0100
From: Kiko Piris <kernel@pirispons.net>
To: Cristiano De Michele <demichel@na.infn.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: laptop mode in 2.4.24
Message-ID: <20040220134218.GA15112@fpirisp.portsdebalears.com>
Mail-Followup-To: Cristiano De Michele <demichel@na.infn.it>,
	linux-kernel@vger.kernel.org
References: <1077276719.6533.16.camel@piro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077276719.6533.16.camel@piro>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2004 at 12:32, Cristiano De Michele wrote:

> that is only journaling is writing to my HD
> and anyway every minute more or less something
> gets written to HD preventing it from being spinned down

IIRC, laptop-mode included in mainline 2.4 does not reset commit
interval of ext3 filesystems (as surely did the patch you applied to
older kernels).

You need to remount your filesystems with appropate commit option. You
can see the updated control script that's in 2.6.*-mm* trees.

-- 
Kiko
