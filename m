Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268163AbUHFQuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268163AbUHFQuN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268191AbUHFQrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:47:23 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:27577 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S268163AbUHFQow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:44:52 -0400
Date: Fri, 6 Aug 2004 18:44:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James Morris <jmorris@redhat.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
Message-ID: <20040806164407.GC2065@wohnheim.fh-wedel.de>
References: <m3wu0cgv6q.fsf@averell.firstfloor.org> <Xine.LNX.4.44.0408061216210.22965-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Xine.LNX.4.44.0408061216210.22965-100000@dhcp83-76.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 August 2004 12:17:59 -0400, James Morris wrote:
> On Fri, 6 Aug 2004, Andi Kleen wrote:
> 
> > You could use .altinstructions to patch a jump in at runtime
> > based on CPU capabilities. Assuming MMX is really faster of course.
> 
> Neat.  The latter could be measured at boot.

Or lazily on first usage.  If it doesn't have to be done at boot time,
why delay the user with it?

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein
