Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVK0MQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVK0MQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 07:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVK0MQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 07:16:08 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:2222 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1751010AbVK0MQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 07:16:08 -0500
Date: Sun, 27 Nov 2005 14:16:04 +0200
From: Ville Herva <vherva@vianova.fi>
To: 7eggert@gmx.de
Cc: Adrian Bunk <bunk@stusta.de>, Folkert van Heusden <folkert@vanheusden.com>,
       linux-kernel@vger.kernel.org
Subject: Re: capturing oopses
Message-ID: <20051127121604.GA6966@vianova.fi>
Reply-To: vherva@vianova.fi
References: <5bG4q-8ks-17@gated-at.bofh.it> <5daDm-1Cg-15@gated-at.bofh.it> <5de3Z-6CJ-13@gated-at.bofh.it> <E1EgB4G-00013Z-9E@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EgB4G-00013Z-9E@be1.lrz>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 02:10:59AM +0100, you [Bodo Eggert] wrote:
> 
> If it's a 640 pixel width image and you've got the right font loaded, the
> VGA function 0x08 will get you the character at the current cursor position.
> It's also used by PRTSCR, so pressing it in a DOS viewer may dump the text
> to LPT1. If you redirected it to a serial console, you might also catch it.
> (I never tried).

I meant that I have the image as a PNG (whatever), captured from the display
of the remote control program (HP RILOE, VMWare GSX Console, VNC, whatever).
I'm aware that the VGA display memory holds the characters (in addition to
pixels) in text mode, but the actual machine may be dead at this point - OS
crash, hw failure, whatever. The oops output is on the screen - just not in
palatible text format.


-- v -- 

v@iki.fi

