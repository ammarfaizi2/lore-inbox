Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUDZWi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUDZWi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 18:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUDZWi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 18:38:58 -0400
Received: from [80.72.36.106] ([80.72.36.106]:30081 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261468AbUDZWi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 18:38:57 -0400
Date: Tue, 27 Apr 2004 00:38:53 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, raven@themaw.net
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?)
In-Reply-To: <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0404270034110.4469@alpha.polcom.net>
References: <20040426013944.49a105a8.akpm@osdl.org>
 <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
 <Pine.LNX.4.58.0404261917120.24825@alpha.polcom.net>
 <Pine.LNX.4.58.0404261102280.19703@ppc970.osdl.org>
 <Pine.LNX.4.58.0404262350450.3003@alpha.polcom.net>
 <Pine.LNX.4.58.0404261510230.19703@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004, Linus Torvalds wrote:
> Try turning off MD first. Then quota, and if neither of those matters, 
> start tuning off the individual filesystem drivers (reiser, xfs).

Yes, when I turned off MD and DM it started to work. Thanks. Can I help 
more to track the problem down? (I currently have no MD or DM volumes in 
my system - I just wanted to start experimenting with them...)


Grzegorz Kulewski

