Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSKITeb>; Sat, 9 Nov 2002 14:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262576AbSKITeb>; Sat, 9 Nov 2002 14:34:31 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:20679 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S262528AbSKITeb>;
	Sat, 9 Nov 2002 14:34:31 -0500
Date: Sat, 9 Nov 2002 13:40:59 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: Neilen Marais <brick@adept.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aty128fb.c does not compile in linux 2.5.46
Message-Id: <20021109134059.27e467a0.arashi@arashi.yi.org>
In-Reply-To: <20021109190405.A17671@brickbox.egghead>
References: <20021109190405.A17671@brickbox.egghead>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Nov 2002 19:04:05 +0200
Neilen Marais <brick@adept.co.za> wrote:

> Hi.
> 
> I don't know if its currently considered important, but just for the 
> record.
> Please CC any replies to me, since I am not subscribed to the list.
> 
> I'm running an AMD Duron/Via kt133, with Debian testing.  Nothing 
> unusual that
> I am aware of.  If I choose to use the ATI Rage128 framebuffer console, 
> I get
> the following compile error:

Yep. There was a recent fbdev API rewrite, not all of the drivers have
been converted yet. (The radeonfb driver, eg, does this too.)

You can fix it by looking at the changesets from the PPC Bitkeeper tree
at http://ppc.bkbits.net:8080/linuxppc-2.5 ... the changes are fairly
straightforward, I did this and got radeonfb working under 2.5.45.

Matt
