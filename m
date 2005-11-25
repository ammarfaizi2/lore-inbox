Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbVKYLT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbVKYLT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 06:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbVKYLT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 06:19:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40907 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751447AbVKYLT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 06:19:27 -0500
Subject: Re: [BUG]: Software compiling occasionlly hangs under
	2.6.15-rc1/rc2 and 2.6.15-rc1-mm2
From: Arjan van de Ven <arjan@infradead.org>
To: Tarkan Erimer <tarkane@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
References: <9611fa230511250312i55d0b872x82b8c33b4d2973e4@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 25 Nov 2005 12:19:24 +0100
Message-Id: <1132917564.7068.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-25 at 11:12 +0000, Tarkan Erimer wrote:
> Hi,
> 
> I'm having some strange software/package compile problem under Gentoo
> and kernels with 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2. When I
> install/update a package via emerge, I got occasional hangs at compile
> time. When this happenned, system continues to work. No error
> messages, no interruption. Just the compile process hangs. Killing
> this hanged process is impossible. Immediately, it becomes Zombie
> process. Also, Reboot and poweroff hangs, too. Just hard
> reboot/poweroff solves it. I've never had this problem under 2.6.14
> and downwards.
> My ver_linux is attached.
> 
> PS: I found a way to reproduce this; installing/updating "man-pages"
> package under Gentoo always hangs.

what is probably needed to diagnose this is that you do a

echo "t" > /proc/sysrq-trigger

and then find the process that hangs in that... and send it to this
list.


