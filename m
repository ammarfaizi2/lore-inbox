Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267211AbSLRI7i>; Wed, 18 Dec 2002 03:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSLRI7i>; Wed, 18 Dec 2002 03:59:38 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:53661 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261561AbSLRI7h>;
	Wed, 18 Dec 2002 03:59:37 -0500
Date: Wed, 18 Dec 2002 10:07:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Anders Fugmann <afu@fugmann.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mousewheel not working.
Message-ID: <20021218100733.A15491@ucw.cz>
References: <3DFF070A.6010804@fugmann.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DFF070A.6010804@fugmann.dhs.org>; from afu@fugmann.dhs.org on Tue, Dec 17, 2002 at 12:14:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 12:14:18PM +0100, Anders Fugmann wrote:
> Hi
> 
> I'm having troubles getting the mosuewheel on my logitech ps/2 mouseman+
> (model M-C48) to work, under 2.5.52. Do I need to add something special 
> to the kernel boot parameters to instruct the driver that my mouse 
> carries 5 buttons?
> 
> dmesg:
> device class 'input': registering
> register interface 'mouse' with class 'input'
> mice: PS/2 mouse device common for all mice
> input: PS2++ Logitech Wheel Mouse on isa0060/serio1
> 
> .config
> 
> CONFIG_INPUT=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set

You have to set X to handle it as ExplorerPS/2.

-- 
Vojtech Pavlik
SuSE Labs
