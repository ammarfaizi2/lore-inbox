Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269126AbUHYBtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269126AbUHYBtj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269125AbUHYBtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:49:39 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:39554 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269122AbUHYBti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:49:38 -0400
Date: Tue, 24 Aug 2004 21:49:37 -0400
From: Tom Vier <tmv@comcast.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-ID: <20040825014937.GC15901@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408220105.25734.gene.heskett@verizon.net> <20040824023418.GD12622@zero> <200408232308.41244.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408232308.41244.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 11:08:41PM -0400, Gene Heskett wrote:
> >are you translating virt->phys?
> 
> No, this is straight out of the memburn output (after I'd fixed the 

that's weird that you're finding that pattern in virtual addresses. i
wouldn't expect that. even if you're booting to single user, certain
variables might change during boot and cause different physical pages to be
mapped. maybe single user is more deterministic than i think, though.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
