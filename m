Return-Path: <linux-kernel-owner+w=401wt.eu-S1752486AbWLQLxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbWLQLxG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 06:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbWLQLxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 06:53:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57647 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbWLQLxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 06:53:05 -0500
Date: Sun, 17 Dec 2006 03:52:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Marc Haber <mh+linux-kernel@zugschlus.de>, linux-kernel@vger.kernel.org,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061217035249.a738e640.akpm@osdl.org>
In-Reply-To: <87hcvv66bm.fsf@mid.deneb.enyo.de>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
	<87hcvv66bm.fsf@mid.deneb.enyo.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 19:31:25 +0100
Florian Weimer <fw@deneb.enyo.de> wrote:

> * Marc Haber:
> 
> > After updating to 2.6.19, Debian's apt control file
> > /var/cache/apt/pkgcache.bin corrupts pretty frequently - like in under
> > six hours.
> 
> I've seen that with Debian's 2.6.18 kernels as well.  Perhaps it's
> related to this Debian bug?
> 
> <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=401006>

ugh, that's pretty damning.  And rtorrent uses MAP_SHARED.
