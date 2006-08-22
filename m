Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWHVXcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWHVXcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 19:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHVXcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 19:32:14 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:26779 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932226AbWHVXcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 19:32:12 -0400
Date: Wed, 23 Aug 2006 01:27:30 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: penberg@cs.Helsinki.FI, akpm@osdl.org, dvrabel@cantab.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
Subject: Re: [PATCH] IP1000A: IC Plus update 2006-08-22
Message-ID: <20060822232730.GA30977@electric-eye.fr.zoreil.com>
References: <1156268234.3622.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156268234.3622.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang <jesse@icplus.com.tw> :
> Dear All:
> I had regenerate this patch from:
> git://git.kernel.org/pub/scm/linux/kernel/git/penberg/netdev-ipg-2.6.git
> 
> And, submit those modifications as one patch.

The suggestion was probably to submit the whole driver as one patch
to akpm for wider testing when it is ready (it still is a bit rough
imho). Unrelated changes make more sense in incremental, isolated
patches as you used to submit before.

I have made some surgery to apply your previous patchset with
former descriptive commit messages, plus your recent codingstyle
changes and a few more.

You'll find it either in branch 'netdev-ipg' at:
git://electric-eye.fr.zoreil.com/home/romieu/linux-2.6.git
or as a serie of patches at:
http://www.fr.zoreil.com/linux/2.6.x/2.6.18-rc4/ip1000

The serie of patches comes straight from the (now old) git tree.
It applies correctly against 2.6.18-git-of-the-day.

The result should not be too far from penberg git + your all-in-one
patch but I have not checked it yet. I'd appreciate if you could
review it.

-- 
Ueimor
