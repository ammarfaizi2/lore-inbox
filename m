Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTJHPyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbTJHPyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:54:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57616 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S261680AbTJHPyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:54:03 -0400
Date: Wed, 8 Oct 2003 16:53:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Matt_Domsch@Dell.com
cc: riel@redhat.com, <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <1065627088.21242.32.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310081648560.3138-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003 Matt_Domsch@Dell.com wrote:
> 
> There definitely is when RMAP is present - we've reproduced it
> repeatedly in our labs.

That would be an argument for changing the rmap patch.

> We've seen a similar failure with the RHEL2.1 kernel w/o RMAP patches
> too.  So we fully believe it's possible in stock 2.4.x.

A similar failure - but what exactly?
And what is the actual race which would account for it?

I don't mind you and Rik fixing bugs!
I'd just like to understand the bug before it's fixed.

Hugh

