Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbRGHQq6>; Sun, 8 Jul 2001 12:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266918AbRGHQqs>; Sun, 8 Jul 2001 12:46:48 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:15630 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S266917AbRGHQqk>; Sun, 8 Jul 2001 12:46:40 -0400
Date: Sun, 8 Jul 2001 17:46:39 +0100
From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
Message-ID: <20010708174639.A7477@xyzzy.clara.co.uk>
In-Reply-To: <200107081026.DAA22119@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107081026.DAA22119@baldur.yggdrasil.com>; from adam@yggdrasil.com on Sun, Jul 08, 2001 at 03:26:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Sun, Jul 08, 2001 at 03:26:48AM -0700, Adam J. Richter wrote:
> 
> 	Yes, although that is a task that is never complete.  So, I
> would recommend that we adopt a simple test that should work into the
> stock kernels with the expectation that the test will probably be
> refined in the future.  Perhaps we could check the Cardbus bridge.
> Does "lspci -v" on your Sony Vaio indicate that its cardbus bridge
> have a subsystem vendor ID of Sony?

OK. lspic -v shows

  CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
  Subsystem: Sony Corporation: Unknown device 8082

Class 0x0607, vendor 0x1180, dev 0x0x0475, subv 0x104D, subd 0x8082

I guess that's a pretty safe signature if the other VAIO lap and
palmtops have it.

-- 
        Bob Dunlop
        rjd@xyzzy.clara.co.uk
        www.xyzzy.clara.co.uk
