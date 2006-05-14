Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWENPqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWENPqu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 11:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWENPqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 11:46:49 -0400
Received: from solarneutrino.net ([66.199.224.43]:19208 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751465AbWENPqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 11:46:49 -0400
Date: Sun, 14 May 2006 11:46:47 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: lockd oopses continue with 2.6.16.1
Message-ID: <20060514154647.GD2677@tau.solarneutrino.net>
References: <20060412172028.GA12637@tau.solarneutrino.net> <1144942392.25298.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1144942392.25298.6.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 11:33:12AM -0400, Trond Myklebust wrote:
> Does the following patch (applies on top of 2.6.17-rc1) help?
> 
> http://client.linux-nfs.org/Linux-2.6.x/2.6.17-rc1/linux-2.6.17-010-fix_nlm_reclaim_races.dif

I've been using the patch linux-2.6.17-012-fix_nlm_reclaim_races.dif vs.
2.6.17-rc2 for almost a month now, and so far it's looking good - no
oopses after several server reboots, and no other problems that I can
see.

-ryan
