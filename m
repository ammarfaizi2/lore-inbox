Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUARV2f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 16:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUARV2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 16:28:35 -0500
Received: from spc1-brig1-3-0-cust85.lond.broadband.ntl.com ([80.0.159.85]:20934
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S263639AbUARV2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 16:28:34 -0500
Date: Sun, 18 Jan 2004 21:28:33 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Szymon Tarnowski <szymon@wpk.p.lodz.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove graphic linux logo on framebuffer, kernel-2-4-24
In-Reply-To: <4241753368.20040118220237@wpk.p.lodz.pl>
Message-ID: <Pine.LNX.4.58.0401182123490.9146@ppg_penguin>
References: <4241753368.20040118220237@wpk.p.lodz.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jan 2004, Szymon Tarnowski wrote:

> Hello everyone
>   I have made this cosmetic patch to remove linux graphics logo
> presented during booting system. I have no objection to logo but when
> console is ready to log in the system, I would like to remove it from
> screen. Because I don`t have enought programing skils and enought free
> time to solve this problem, I made this patch to remove logo at all.
> It is made by changing value sent do framebuffer setup routine. Please
> fell free to coment my patch, please send it to me directly because I
> don`t receive subscription from linux-kernel message list. Please also
> inform me if there will be big discusion at list.
>
>

Why ?

 If your problem is that a few lines at the top of your screen stay
blank, there are two existing solutions:

(a) switch to another console, then back.
(b) create an init script using `setfont' to set a font of your choice.

Ken
-- 
This is a job for Riviera Kid!
