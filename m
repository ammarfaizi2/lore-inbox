Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264607AbUD1C1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbUD1C1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 22:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264617AbUD1C1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 22:27:46 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:47278 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264607AbUD1C1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 22:27:45 -0400
Date: Wed, 28 Apr 2004 03:27:43 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Ian Kent <raven@themaw.net>
Cc: Paul Jackson <pj@sgi.com>, Erdi Chen <erdi.chen@digeo.com>,
       davem@redhat.com, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
In-Reply-To: <Pine.LNX.4.58.0404281025060.651@wombat.indigo.net.au>
Message-ID: <Pine.LNX.4.58.0404280325340.2125@skynet>
References: <20040426204947.797bd7c2.pj@sgi.com>
 <Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au>
 <Pine.LNX.4.58.0404272234320.1547@donald.themaw.net> <Pine.LNX.4.58.0404280111430.2125@skynet>
 <Pine.LNX.4.58.0404281025060.651@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
>
> I'll investigate but I think that, either I need the fb device or
> X -configure has it wrong. It thinks I have devices fb0 and fb1.

leave in the "fb" device but don't enable direct rendering "ffb" device,
not the extra f, if it still crashes with just the framebuffer and not the
DRM then there is a framebuffer issue ...

CONFIG_DRM_FFB should be n is probably the most straightforward way to
check it isn't in there..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

