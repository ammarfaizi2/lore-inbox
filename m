Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVBMPug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVBMPug (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 10:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVBMPug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 10:50:36 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:7954 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261282AbVBMPub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 10:50:31 -0500
Message-Id: <200502131813.j1DICsnW002251@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: "Vadim Abrossimov" <vadim_abrossimov@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uml: support a separate build tree; support USER_OBJS dependencies 
In-Reply-To: Your message of "Sun, 13 Feb 2005 15:19:11 +0100."
             <opsl43d9yilfdzum@localhost.localdomain> 
References: <opsl43d9yilfdzum@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Feb 2005 13:12:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vadim_abrossimov@yahoo.com said:
> 1. To support a separate build tree for the um/i386 architecture the
> following changes have been done: 

Have a look at 
	http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.11-rc3-mm2/patches/cross-build

That's Al Viro's take on the same problem, plus -j and some other things he
noted in passing.

If you could remove the stuff that's common (and flag the overlapping, but 
different things) from your patch, that would be helpful.

				Jeff
