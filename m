Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266775AbUHDE1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUHDE1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 00:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUHDE1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 00:27:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:64903 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266775AbUHDE1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 00:27:17 -0400
X-Authenticated: #420190
Message-ID: <4110660D.5050003@gmx.net>
Date: Wed, 04 Aug 2004 06:29:01 +0200
From: Marko Macek <Marko.Macek@gmx.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Eric Wong <eric@yhbt.net>
Subject: Re: KVM & mouse wheel
References: <410FAE9B.5010909@gmx.net> <Pine.LNX.4.60.0408032257250.2821@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.60.0408032257250.2821@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> <>I also had problems with my KVM switch and mouse when I initially 
> moved to
> 2.6, but adding this kernel boot parameter fixed it, meybe it will help
> you as well : psmouse.proto=imps

This doesn't help. Only the patch I sent helps me. The problem is that the
even with psmouse.proto=imps or exps, the driver still probes for 
synaptics which I
consider a bug.

>My mouse is a "Logitec MouseMan Wheel" (USB mouse, but connected to the 
>
I have this one too (besides MX), same problem. The problem is really the
KVM switch and the 2.6 mouse driver.

Mark
