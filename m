Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUEWUc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUEWUc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 16:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUEWUc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 16:32:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:10908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263574AbUEWUcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 16:32:22 -0400
Date: Sun, 23 May 2004 13:32:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Phy Prabab <phyprabab@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
In-Reply-To: <20040523194302.81454.qmail@web90007.mail.scd.yahoo.com>
Message-ID: <Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org>
References: <20040523194302.81454.qmail@web90007.mail.scd.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 May 2004, Phy Prabab wrote:
> 
> I have been researching the 4g patches for kernels. 
> Seems there was a rift between people over this.  Is
> there any plan to resume publishing 4g patches for
> developing kernels?

Quite frankly, a number of us are hoping that we can make them
unnecessary. The cost of the 4g/4g split is absolutely _huge_ on some
things, including basic stuff like kernel compiles.

The only valid reason for the 4g split is that the VM doesn't always 
behave well with huge amounts of highmem. The anonvma stuff in 2.6.7-pre1 
is hoped to make that much less of an issue.

Personally, if we never need to merge 4g for real, I'll be really really 
happy. I see it as a huge ugly hack.

			Linus
