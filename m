Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUJCH1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUJCH1F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 03:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUJCH1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 03:27:05 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:5097 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267746AbUJCH05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 03:26:57 -0400
Date: Sun, 3 Oct 2004 08:26:54 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dri-devel@lists.sf.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Merging DRM and fbdev
In-Reply-To: <9e47339104100220553c57624a@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0410030824280.2325@skynet>
References: <9e47339104100220553c57624a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In this model a non-drm, fb only driver like cyber2000 could load only
> the fb and fbcon modules. I need to do some work rearranging generic
> library support functions to allow this.
>

I think the stated issue with this is, how big the fb driver now becomes
because all the DRM stuff is in it... I think a radeon common, with
radeonfb/radeondrm is probably going to be needed,

Hopefully tomorrow (I've a day off, but the weather is getting nice as
well :-), I'll get some time to port some stuff to the vga class stuff,

I also want to prepare some patches for the kernel for the previous work
you've done ...

Dave.
