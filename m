Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263623AbUDZWNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUDZWNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 18:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUDZWN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 18:13:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:50408 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263623AbUDZWN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 18:13:28 -0400
Date: Mon, 26 Apr 2004 15:13:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?)
In-Reply-To: <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
Message-ID: <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org>
References: <20040426013944.49a105a8.akpm@osdl.org>
 <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
 <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Apr 2004, Grzegorz Kulewski wrote:
> 
> Have you any ideas what could cause the problem and what options should I 
> add from not working to working config or should I start binary search? 
> (On my machine kernel compiles painfully slow, so I will be glad to hear 
> you have an idea where should I look...)

Try turning off MD first. Then quota, and if neither of those matters, 
start tuning off the individual filesystem drivers (reiser, xfs).

		Linus
