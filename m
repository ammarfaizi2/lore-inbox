Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTI2L2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 07:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbTI2L2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 07:28:25 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:41857 "EHLO
	catv-50624ad9.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S263122AbTI2L2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 07:28:23 -0400
Message-ID: <3F781755.5050504@freemail.hu>
Date: Mon, 29 Sep 2003 13:28:21 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.2.1) Gecko/20030225
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Havoc Pennington <hp@redhat.com>
Subject: Re: 2.6.0-test6-mm1
References: <3F780255.6010408@freemail.hu>
In-Reply-To: <3F780255.6010408@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan írta:
> It gets stuck, not always, but very often. The exact problem
> is that on a menu draw (e.g. on entering a submenu or going
> one level up) the gnome-terminal window is cleared (everything
> is repainted with the background color) but the newly selected
> menu does not appear.
> 
> gnome-terminal starts (or tries to start) eating 100% CPU,

> I am cc-ing Havoc Pennington (I found his address in
> gnome-terminal's About dialog), he may know where to fix or
> he can confirm that a newer gnome-terminal is already fixed.

Mingo suggested to upgrade XFree86-4.3.0-33 from rawhide so I can
test and use his exec-shield. I went further and upgraded some more
packages: glibc*-2.3.2-91, nptl-devel-2.3.2-91, nscd-2.3.2-91,
rpm-4.2.1-0.30 (so I don't need LD_ASSUME_KERNEL as root)
and finally: gnome-terminal-2.4.0.1, vte[-devel]-0.11.10-4.
It fixed the problem.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

