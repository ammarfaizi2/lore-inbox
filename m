Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUA3Qu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUA3Qu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:50:58 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:13451 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261890AbUA3Qu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:50:57 -0500
Date: Fri, 30 Jan 2004 17:50:55 +0100
From: David Weinehall <tao@acc.umu.se>
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.0.40-rc8
Message-ID: <20040130165055.GT16675@khan.acc.umu.se>
Mail-Followup-To: Seiichi Nakashima <nakasima@kumin.ne.jp>,
	linux-kernel@vger.kernel.org
References: <200401171453.AA00009@prism.kumin.ne.jp> <200401301505.AA00013@prism.kumin.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401301505.AA00013@prism.kumin.ne.jp>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 12:05:29AM +0900, Seiichi Nakashima wrote:
> Hi.
> 
> I update linux-2.0.40-rc8 from 2.0.40-rc6, compile and work fine.
> these warning error exist in my environment(slackware-3.9 base).
> 
> ialloc.c: In function `ext2_new_inode':
> ialloc.c:302: warning: `bh2' might be used uninitialized in this function
> ialloc.c:452: warning: `bh' might be used uninitialized in this function

Ok.  I think that you can ignore these warnings without worries, but
I'll investigate this before releasing 2.0.40 anyway.

Thanks for reporting!


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
