Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbUCSOVn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUCSOVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:21:43 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:56237 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262704AbUCSOVl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:21:41 -0500
Message-ID: <405B01E7.5000809@stesmi.com>
Date: Fri, 19 Mar 2004 15:21:27 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
References: <20040316182409.54329.qmail@web80508.mail.yahoo.com> <20040318203717.GA4430@ucw.cz> <200403190005.36956.dtor_core@ameritech.net> <20040319135819.GB658@ucw.cz>
In-Reply-To: <20040319135819.GB658@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> So far on every machine I've got a report from it was caused by BIOS
> emulation of PS/2 mouse using an USB mouse (even when USB mouse wasn't
> present). Compiling the USB modules into the kernel fixes the problem.

Could this have anything to do with the fact that my x86-64 kernel nukes
on startup if USB keyboard/mouse emul is enabled in the BIOS?

This is on an ASUS K8T800 and an MSI K8T800 board.

If you don't know what I'm talking about I'll give more info of course.

// Stefan
