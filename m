Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVLATE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVLATE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbVLATE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:04:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1437 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751705AbVLATE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:04:27 -0500
Date: Thu, 1 Dec 2005 11:04:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kasper Sandberg <lkml@metanurb.dk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
In-Reply-To: <1133463473.16820.3.camel@localhost>
Message-ID: <Pine.LNX.4.64.0512011101400.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org> 
 <1133445903.16820.1.camel@localhost>  <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org>
 <1133463473.16820.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Dec 2005, Kasper Sandberg wrote:
>
> im not sure its a good idea to silence this, because this seems to be a
> genuine error, the ati proprietary driver is not working.. if i try to
> use 3d, it will display this message again, and the process trying to
> use 3d will freeze, and become unkillable.

Ok, that's a totally different issue. That implies that my emulation of 
the old behaviour simply isn't working very well.

Do you have full logs for that machine? In particular, I'd really like to 
hear whether you have any of those

	"<process-name> does an incomplete pfn remapping"

messages, and what the details were for that case. Same goes for what the 
page flags and counts were in the "Bad page state at.." messages.

			Linus
