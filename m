Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVCPO43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVCPO43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVCPO4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:56:11 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19177 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262611AbVCPOyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:54:38 -0500
Date: Wed, 16 Mar 2005 07:54:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bastos Fernandez Alexandre <ALEBAS@televes.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Leo Li <leoli@freescale.com>,
       "Balasaygun, Oray (Oray)" <oray@lucent.com>
Subject: Re: [PATCH] ppc32: Update 8260_io/fcc_enet.c to function again
Message-ID: <20050316145435.GY8345@smtp.west.cox.net>
References: <51DB8827D393D411BB69003048003F46FDCFDE@tvesntr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51DB8827D393D411BB69003048003F46FDCFDE@tvesntr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 09:00:51AM +0100, Bastos Fernandez Alexandre wrote:

> What can we do?
> Has Oray's patch been commited? Or not yet?
> 
> I suggest commiting all the changes in this driver from linuxppc tree to
> linux tree
> and after this ask Oray to test again the driver and submmit new patch.
> Or ask Oray to submmit changes patch to linuxppc 

So, Oray's patch has two things in it, it looks like.  The basic
re-porting to 2.6 APIs, and support for the EON8260.  The EON8260
changes should be a bit cleaner to redo after the patch I sent goes in
as some of the other cleanups will help there.  But I'd also like to see
the full EON8260 changes :)  The 2.6 API parts look close, but I went
and expanded a good bit more on them.

I'd like to drop Oray's patch for now, and have the EON8260 work be
resubmitted to lkml/linuxppc-embedded@ozlabs.org.

-- 
Tom Rini
http://gate.crashing.org/~trini/
