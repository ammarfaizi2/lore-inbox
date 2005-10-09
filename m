Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVJIRN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVJIRN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 13:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVJIRN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 13:13:58 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:64530 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S932137AbVJIRN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 13:13:57 -0400
Message-ID: <43494FD0.8080501@roarinelk.homelinux.net>
Date: Sun, 09 Oct 2005 19:13:52 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: "Antonino A. Daplas" <adaplas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Modular i810fb broken, partial fix
References: <200510071547.14616.bero@arklinux.org> <4347C39F.2020703@pol.net> <4347E611.9040705@roarinelk.homelinux.net> <200510091848.19345.bero@arklinux.org>
In-Reply-To: <200510091848.19345.bero@arklinux.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> On Saturday, 8. October 2005 17:30, Manuel Lauss wrote:
> 
>>for reference:
>>modprobe i810fb mode_option=1024x768-8@60 hsync1=40 hsync2=60 vsync1=50
>>vsync2=70 vram=4
> 
> 
> Can you try with 1024x768-16@60? That's what we're using in the installer (and 
> what people reported to gable the display).

tried with -16 and -32, with/without accel=1, mtrr=1, extvga=1,
no problems. I _do_ see problems with >8 bpp when
warm-rebooting from windows. Cursor is a 8 character long
random pixelpile or a 3x3 ch blinking block of text.
 Cold boot and warm-rebooting from linux
are okay though (I suspect bios does not reset accel engine).

-- 
 mano
