Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVAQPI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVAQPI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 10:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVAQPI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 10:08:29 -0500
Received: from mail.tnnet.fi ([217.112.240.26]:11493 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S261372AbVAQPII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 10:08:08 -0500
Message-ID: <41EBD4D4.882B94D@users.sourceforge.net>
Date: Mon, 17 Jan 2005 17:08:04 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
References: <41EAE36F.35354DDF@users.sourceforge.net> <41EB3E7E.7070100@tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Is this eventually going in the mainline kernel? I'd like to use it, but
> if I'm going to have to maintain my own crypto kernels indefinitely this
> probably isn't the one for me.

Unlikely to go to mainline kernel. Mainline folks are just too much in love
with their backdoored device crypto implementations [1]. If you want strong
device crypto in mainline kernel, maybe you should take a look at FreeBSD
gbde.

[1]  http://marc.theaimsgroup.com/?l=linux-kernel&m=107419912024246&w=2

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
