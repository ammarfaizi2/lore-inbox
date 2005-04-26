Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVDZVFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVDZVFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 17:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVDZVFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 17:05:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:6086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261785AbVDZVFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 17:05:45 -0400
Date: Tue, 26 Apr 2005 14:07:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Magnus Damm <magnus.damm@gmail.com>, mason@suse.com, mike.taht@timesys.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
In-Reply-To: <20050426135606.7b21a2e2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com>
 <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com>
 <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Apr 2005, Andrew Morton wrote:
> 
> Mounting as ext2 is a useful technique for determining whether the fs is
> getting in the way.

What's the preferred way to try to convert a root filesystem to a bigger
journal? Forcing "rootfstype=ext2" at boot and boot into single-user, and
then the appropriate magic tune2fs? Or what?

		Linus
