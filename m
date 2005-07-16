Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVGPKNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVGPKNt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 06:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVGPKNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 06:13:48 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:4563
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261398AbVGPKMt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 06:12:49 -0400
Date: Sat, 16 Jul 2005 11:12:48 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kconfig: lxdialog: Enable UTF8
In-Reply-To: <20050716095450.GC8064@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0507161108150.465@ppg_penguin.kenmoffat.uklinux.net>
References: <1121273456.2975.3.camel@spirit> <1121274450.2975.12.camel@spirit>
 <Pine.LNX.4.61.0507131916060.9023@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0507140117210.18332@ppg_penguin.kenmoffat.uklinux.net>
 <20050716095450.GC8064@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jul 2005, Sam Ravnborg wrote:

> >
> > OK, I'll bite - non utf8 here, and no libncursesw : a quick google
> > suggests I can get it if I recompile ncurses with --enable-widec, but
> > why would I want to do that ?
> Could you try if specifying both libraries works for you. the 'w'
> version first. Then we can use the 'w' version when available but
> fall-back to the normal case if not.
>
> 	Sam
>

 Didn't work, I get the not unexpected "cannot find -lncursesw".  I
think some sort of pre-test will be needed to see which one exists.
I'm weak on doing this in a Makefile, but I'll have a look tonight or
tomorrow.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

