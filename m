Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTEKSJN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTEKSJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:09:12 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:51095 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261835AbTEKSJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:09:11 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 11 May 2003 11:23:48 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
In-Reply-To: <m1fznl74f9.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.50.0305111119590.7563-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
 <200305111137.29743.josh@stack.nl> <20030511140144.GA5602@mail.jlokier.co.uk>
 <Pine.LNX.4.50.0305111033590.7563-100000@blue1.dev.mcafeelabs.com>
 <m1fznl74f9.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, Eric W. Biederman wrote:

> The remapping is quite common but it usually happens that after bootup:
> 0xf0000-0xfffff is shadowed RAM.  While 0xffff0000-0xffffffff still points
> to the rom chip.
>
> Now if someone could tell me how to do a jump to 0xffff0000:0xfff0 in real
> mode I would find that very interesting.

Have you ever heard about unreal mode ? But I do not think that a reset
has to start over there. I do not think that exist hw/sw that expect that
reset address to be 0xfffffff0 instead of 0x000ffff0, since they map the
same content.



- Davide

