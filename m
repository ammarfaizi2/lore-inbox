Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUEXFmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUEXFmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 01:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUEXFk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 01:40:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:49377 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263979AbUEXFku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 01:40:50 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ben LaHaise <bcrl@redhat.com>, linux-mm@kvack.org
In-Reply-To: <20040524073929.GA23216@elte.hu>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040524073929.GA23216@elte.hu>
Content-Type: text/plain
Message-Id: <1085377151.15025.51.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 15:39:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-24 at 17:39, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Who else has been working on the page tables that could verify this
> > for me? Ingo? Ben LaHaise? I forget who even worked on this, because
> > it's so long ago we went through all the atomicity issues with the
> > page table updates on SMP. There may be some reason that I'm
> > overlooking that explains why I'm full of sh*t.
> 
> Ben's the master of atomic dirty pte updates! :)

Precise which Ben :) Well, in this case it's obvious but still.. :)

Ben.


