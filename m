Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVGNA0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVGNA0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVGNA0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:26:06 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:15562
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261594AbVGNA0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:26:04 -0400
Date: Thu, 14 Jul 2005 01:26:03 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kconfig: lxdialog: Enable UTF8
In-Reply-To: <Pine.LNX.4.61.0507131916060.9023@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0507140117210.18332@ppg_penguin.kenmoffat.uklinux.net>
References: <1121273456.2975.3.camel@spirit> <1121274450.2975.12.camel@spirit>
 <Pine.LNX.4.61.0507131916060.9023@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, Jan Engelhardt wrote:

> Hi,
>
>
> utf-8 enabled vc consoles (/dev/tty1) usually show line drawing
> graphics with the ascii set, e.g. + - and | for lxdialog (and many other apps
> btw)
>
> The following patch brings back the real graphics for lxdialog, which are
> normally present in these cases:
> - non-utf8 vc
> - xterm (u8 / non-u8)
>

OK, I'll bite - non utf8 here, and no libncursesw : a quick google
suggests I can get it if I recompile ncurses with --enable-widec, but
why would I want to do that ?

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

