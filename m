Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270581AbTGTApO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 20:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270582AbTGTApO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 20:45:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:44955 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270581AbTGTApM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 20:45:12 -0400
Date: Sat, 19 Jul 2003 18:01:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-Id: <20030719180105.53b1226c.akpm@osdl.org>
In-Reply-To: <m2wuee9hdo.fsf@telia.com>
References: <m2wueh2axz.fsf@telia.com>
	<20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org>
	<m2d6g8cg06.fsf@telia.com>
	<20030718032433.4b6b9281.akpm@osdl.org>
	<20030718152205.GA407@elf.ucw.cz>
	<m2el0nvnhm.fsf@telia.com>
	<20030718094542.07b2685a.akpm@osdl.org>
	<m2oezrppxo.fsf@telia.com>
	<20030718131527.7cf4ca5e.akpm@osdl.org>
	<m2wuee9hdo.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> I have tried the change, but the writeout is still very slow. (Maybe
> somewhat faster than the original code, but far from being limited by
> disk bandwidth.)

Did you fix swsusp to leave kswapd unrefrigerated during the shrink?  If
not, the change wouldn't make any difference.

