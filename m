Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTEJVjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 17:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264517AbTEJVjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 17:39:39 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:7299
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264516AbTEJVji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 17:39:38 -0400
Date: Sat, 10 May 2003 17:42:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jos Hulzink <josh@stack.nl>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: irq balancing: performance disaster
In-Reply-To: <200305110118.10136.josh@stack.nl>
Message-ID: <Pine.LNX.4.50.0305101740500.14808-100000@montezuma.mastecende.com>
References: <200305110118.10136.josh@stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, Jos Hulzink wrote:

> While tackling bug 699, it became clear to me that irq balancing is the cause 
> of the performance problems I, and all people using the SMP kernel Mandrake 
> 9.1 ships, are dealing with. I got the problems with 2.5.69 too. After 
> disabling irq balancing, the system is remarkably faster, and much more 
> responsive. 

Alan fixed this in his tree a little while back, Mandrake didn't manage to 
squeeze that fix in. The 2.5 and 2.4 situation is different however, for 
2.5 it's intentional, for 2.4 something broke.

	Zwane
--
function.linuxpower.ca
