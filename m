Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTJ0Vws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 16:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTJ0Vws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 16:52:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:32930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263590AbTJ0Vwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 16:52:47 -0500
Date: Mon, 27 Oct 2003 14:02:19 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix device suspend/resume handling
In-Reply-To: <20031022233127.GA6410@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0310271401590.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [Oops, this one:
> 
> -               if(drivers_suspend()==0)
> +               if ((res = device_suspend(4))==0)
> 
> probably will reject. Sorry about that, should be easy to fix up].

Please send an applicable patch.

Thanks,


	Pat

