Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUAKQyY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265916AbUAKQyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:54:24 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:62625 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265840AbUAKQyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:54:23 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 11 Jan 2004 08:53:32 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Bart Samwel <bart@samwel.tk>
cc: Tim Cambrant <tim@cambrant.com>, Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
 0x37ffffff" warning.
In-Reply-To: <4001569C.3010700@samwel.tk>
Message-ID: <Pine.LNX.4.44.0401110852030.19685-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jan 2004, Bart Samwel wrote:

> Now it seems to behave correctly: for '~' it always warns, for '-' it 
> only warns if the negative value is below -0x80000000. I'll submit a 
> patch to this effect (including the format extensions) to the binutils 
> people.

binutils 2.14 works fine, so I believe they already fixed it.



- Davide


