Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262255AbSKCSFL>; Sun, 3 Nov 2002 13:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262276AbSKCSFL>; Sun, 3 Nov 2002 13:05:11 -0500
Received: from modemcable077.18-202-24.mtl.mc.videotron.ca ([24.202.18.77]:63236
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262255AbSKCSFK>; Sun, 3 Nov 2002 13:05:10 -0500
Date: Sun, 3 Nov 2002 13:14:34 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5-AC] cistpl.c pcibios_read_config_dword
In-Reply-To: <20021103175910.D5589@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211031313350.14075-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Russell King wrote:

> There is a patch that fixes this floating around.  The above isn't correct,
> because we don't want to read s->cap.cb_dev (which is the bridge), but we
> want to read the cardbus device that was just plugged in.

Thanks for the correction, i'll look around for the proper fix.

Cheers,	
	Zwane
-- 
function.linuxpower.ca

