Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVAPABb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVAPABb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 19:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVAPABb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 19:01:31 -0500
Received: from [81.2.110.250] ([81.2.110.250]:54914 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262371AbVAPABa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 19:01:30 -0500
Subject: Re: Make pipe data structure be a circular list of pages, rather
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux@horizon.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ioe-lkml@axxeo.de, torvalds@osdl.org
In-Reply-To: <20050115234204.20123.qmail@science.horizon.com>
References: <20050115234204.20123.qmail@science.horizon.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105829719.16028.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 22:55:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-01-15 at 23:42, linux@horizon.com wrote:
> The beauty of Linus's scheme is that direct hardware-to-hardware
> copying is possible, without inventing new kernel interfaces.

You appear to need some simple kernel interfaces but not many and the
low level is there. This looks much cleaner (although perhaps not as
clever yet on the invalidation/cache side) as Matt  Dillon and Alan Cox
(the other Alan Cox not me) are doing on Dragonfly BSD in the same sort
of direction.

