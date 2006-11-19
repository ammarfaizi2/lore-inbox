Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933241AbWKSUg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241AbWKSUg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933242AbWKSUg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:36:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933241AbWKSUg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:36:58 -0500
Date: Sun, 19 Nov 2006 12:36:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: [git pull] PCMCIA fixes for 2.6.19-rc6
Message-Id: <20061119123636.6219351d.akpm@osdl.org>
In-Reply-To: <20061119163427.GA2924@dominikbrodowski.de>
References: <20061119163427.GA2924@dominikbrodowski.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006 11:34:27 -0500
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Hej Linus,
> 
> Please pull from
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-fixes-2.6.git/
> 
> ...
>
>       pcmcia: fix 'rmmod pcmcia' with leftover devices

Is this the patch about which Daniel said "does not fix the problem:
ds.c:ds_event() will never be called because s->callback is set to NULL
just before send_event() which means send_event() does nothing at all.."?
