Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268958AbRHCLxm>; Fri, 3 Aug 2001 07:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268965AbRHCLxc>; Fri, 3 Aug 2001 07:53:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5132 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268958AbRHCLxX>; Fri, 3 Aug 2001 07:53:23 -0400
Subject: Re: kernel gdb for intel
To: akale@veritas.com (Amit S. Kale)
Date: Fri, 3 Aug 2001 12:54:53 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), baccala@freesoft.org (Brent Baccala),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <no.id> from "Amit S. Kale" at Aug 03, 2001 03:37:06 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SdXZ-0002oY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't get this. How can two gdb stubs work correctly
> on two serial ports? In absence of any globals, there won't be
> any data corruption, though there are inherent assumptions in 
> the kernel about progress on all cpus. If GKL, page cache lock etc
> are held by one cpu, the other cpu will not be able to make
> any/much progress.

That is fine. It'll get stuck in a lock. One thing it was useful for was
exactly that - getting a given point and checking the locking cases worked

