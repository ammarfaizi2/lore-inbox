Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWAFTGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWAFTGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWAFTGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:06:42 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22947 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932467AbWAFTGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:06:39 -0500
Date: Fri, 6 Jan 2006 20:06:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
In-Reply-To: <20060106152203.GA11906@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0601062006110.28630@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com> <1136468254.16358.23.camel@localhost.localdomain>
 <20060105205221.GN20809@redhat.com> <20060106152203.GA11906@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No.
>
>But you _know_ if user is running X or not -- notice that kernel does
>not attempt to printk() when X is running, because that could lock up
>the box.
>
>If user is running X, you don't need the delay.
>
>if (CON_IS_VISIBLE(vc) && vc->vc_mode == KD_TEXT) {

Does framebuffer fall under KD_TEXT?


Jan Engelhardt
-- 
