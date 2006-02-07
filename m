Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWBGVuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWBGVuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 16:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWBGVuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 16:50:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:13698 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S965112AbWBGVug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 16:50:36 -0500
Subject: Re: Badness in sleep_on_timeout on kernel 2.6.9-1.667 ( fedora
	core 3)
From: David Woodhouse <dwmw2@infradead.org>
To: anil dahiya <ak_ait@yahoo.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <20060207200013.30703.qmail@web60221.mail.yahoo.com>
References: <20060207200013.30703.qmail@web60221.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 21:50:28 +0000
Message-Id: <1139349028.3482.47.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 12:00 -0800, anil dahiya wrote:
>  Badness in sleep_on_timeout at kernel/sched.c:3022
>  [<02302bc3>] sleep_on_timeout+0x5d/0x23a
>  [<0211b919>] default_wake_function+0x0/0xc
> 
> can any suggest how i can avoid this oops.

Stop using sleep_on_timeout(). It's almost certainly buggy.

-- 
dwmw2

