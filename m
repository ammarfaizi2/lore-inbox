Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUBLQT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUBLQT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:19:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:56773 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266507AbUBLQTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:19:25 -0500
Date: Thu, 12 Feb 2004 08:19:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PPC64 PowerMac G5 support available
In-Reply-To: <Pine.LNX.4.58.0402120757120.5816@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402120818160.5816@home.osdl.org>
References: <1076563481.2285.167.camel@gaston> <Pine.LNX.4.58.0402120757120.5816@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Feb 2004, Linus Torvalds wrote:
> 
> Does the appended fix it?

It can't, since it's missing a "get_device()" at the top of the loop.  But 
with that fixed it should hopefully be gone.. (Noted by Ben Collins)

		Linus
