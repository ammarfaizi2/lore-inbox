Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUH0Xzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUH0Xzj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUH0Xzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:55:39 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:33246 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264502AbUH0Xzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:55:33 -0400
Date: Sat, 28 Aug 2004 00:55:32 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: drm fixup 1/2 - missing bus_address assignment
In-Reply-To: <20040827152110.A31641@infradead.org>
Message-ID: <Pine.LNX.4.58.0408280054580.23054@skynet>
References: <Pine.LNX.4.58.0408271510530.32411@skynet> <20040827152110.A31641@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +			buf->bus_address = virt_to_bus(buf->address);
>
> this iw wrong.  never use virt_to_bus in new code and whenever you see it
> in old code get rid of it.
>

Is there an alternative or do I just dump it? I think we only use the
bus_address for debugging in /proc and I don't think many people actually
have used it ..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

